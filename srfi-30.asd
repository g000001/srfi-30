;;;; srfi-30.asd

(cl:in-package :asdf)

(defsystem :srfi-30
  :serial t
  :depends-on (:srfi-5 :srfi-23)
  :components ((:file "package")
               (:file "srfi-30")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-30))))
  (load-system :srfi-30)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-30-internal :srfi-30))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

