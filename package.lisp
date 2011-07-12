;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-30
  (:use)
  (:export))

(defpackage :srfi-30-internal
  (:use :srfi-30 :cl :fiveam
        :srfi-23 :srfi-5)
  (:shadowing-import-from :srfi-5 :let)
  (:shadowing-import-from :srfi-23 :error))

