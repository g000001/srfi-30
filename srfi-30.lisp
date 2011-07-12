;;;; srfi-30.lisp

(cl:in-package :srfi-30-internal)

(def-suite srfi-30)

(in-suite srfi-30)

#|(defconstant eof
  (if (boundp 'eof)
      (symbol-value 'eof)
      (gensym "eof-")))|#

#|(defun eof-object? (obj)
  (eq eof obj))|#


#|(defun skip-comment! (&rest maybe-start-state)
  (let lp ((state (if (null maybe-start-state) 'start (car maybe-start-state)))
	   (nested-level 0))
       (flet ((next-char ()
                (let ((c (read-char)))
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
                           (otherwise (lp 'start nested-level))))))))|#
