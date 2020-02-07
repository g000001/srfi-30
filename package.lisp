;;;; package.lisp

(cl:in-package cl-user)

(defpackage "https://github.com/g000001/srfi-30"
  (:use)
  (:export enable-srfi-30
           disable-srfi-30))

(defpackage "https://github.com/g000001/srfi-30#internals"
  (:use "https://github.com/g000001/srfi-5"
        "https://github.com/g000001/srfi-23"
        "https://github.com/g000001/srfi-30"
        cl
        fiveam)
  (:shadowing-import-from "https://github.com/g000001/srfi-5"
                          let)
  (:shadowing-import-from "https://github.com/g000001/srfi-23"
                          error))

