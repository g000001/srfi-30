;;;; srfi-30.asd

(cl:in-package :asdf)


(defsystem :srfi-30
  :version "20200207"
  :description "SRFI 30: Nested Multi-line Comments"
  :long-description "SRFI 30: Nested Multi-line Comments
https://srfi.schemers.org/srfi-30"
  :author "Mike Sperber"
  :maintainer "CHIBA Masaomi"
  :license "Unlicense"
  :serial t
  :depends-on (:srfi-5 :srfi-23)
  :components ((:file "package")
               (:file "srfi-30")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-30))))
  (let ((name "https://github.com/g000001/srfi-30")
        (nickname :srfi-30))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-30))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-30#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-30)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
