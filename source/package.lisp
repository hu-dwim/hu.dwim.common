;;; -*- mode: Lisp; Syntax: Common-Lisp; -*-
;;;
;;; Copyright (c) 2009 by the authors.
;;;
;;; See LICENCE for details.

(in-package :common-lisp-user)

(defpackage :hu.dwim.common
  (:use :alexandria
        :anaphora
        :closer-mop
        :hu.dwim.common-lisp
        :iterate
        :metabang-bind)

  (:shadowing-import-from :closer-mop
                          #:defgeneric
                          #:defmethod
                          #:ensure-generic-function
                          #:find-method
                          #:remove-method
                          #:standard-class
                          #:standard-generic-function)

  (:export #:export-external-symbols
           #:export-external-symbols-of-used-packages))
