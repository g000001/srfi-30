;;;; srfi-30.lisp

(cl:in-package "https://github.com/g000001/srfi-30#internals")


(def-suite srfi-30)


(in-suite srfi-30)


(defconstant eof
  (if (boundp 'eof)
      (symbol-value 'eof)
      (gensym "eof-")))


(defun eof-object? (obj)
  (eq eof obj))


(defun skip-comment! (&rest maybe-start-state)
  (let lp ((state (if (null maybe-start-state) 'start (car maybe-start-state)))
	   (nested-level 0))
    (flet ((next-char ()
             (let ((c (read-char)))
               (print c)
               (if (eof-object? c)
                   (error "EOF inside block comment -- #| missing a closing |#")
                   c))))
      (case state
        ((start) (case (next-char)
                   ((#\|) (lp 'read-bar nested-level))
                   ((#\#) (lp 'read-sharp nested-level))
                   (otherwise (lp 'start nested-level))))
        ((read-bar) (case (next-char)
                      ((#\#) (if (> nested-level 1)
                                 (lp 'start (- nested-level 1))))
                      (otherwise (lp 'start nested-level))))
        ((read-sharp) (case (next-char)
                        ((#\|) (lp 'start (+ nested-level 1)))
                        (otherwise (lp 'start nested-level))))))))


(defun enable-srfi-30 (&optional (rt *readtable*))
  (let* ((dsp #\#)
         (sub #\|)
         (fct (lambda (srm chr arg)
                (declare (ignore arg))
                (let ((*standard-input* srm))
                  (unread-char chr srm)
                  (unread-char #\# srm)
                  (skip-comment! 'start))
                (values))))
    (set-dispatch-macro-character dsp sub fct rt)))


(defun disable-srfi-30 (&optional (rt *readtable*))
  (let* ((dsp #\#)
         (sub #\|)
         (fct (get-dispatch-macro-character dsp
                                            sub
                                            (copy-readtable nil))))
    (set-dispatch-macro-character dsp sub fct rt)))


(test |srfi-30 vs cl|
  (let ((code "#|
                0
                #|
                1
                |#
                #|
                2
                |#
                |#
                end"))
    (is (eq (let ((*readtable* (copy-readtable nil)))
              (set-dispatch-macro-character #\# #\| nil)
              (enable-srfi-30)
              (disable-srfi-30)
              (read-from-string code))
            (read-from-string code)))))


;;; *EOF*
