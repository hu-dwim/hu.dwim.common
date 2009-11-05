;;; -*- mode: Lisp; Syntax: Common-Lisp; -*-
;;;
;;; Copyright (c) 2009 by the authors.
;;;
;;; See LICENCE for details.

(in-package :hu.dwim.common)

(defun export-external-symbols (source-package target-package &key filter (if-exists :ignore))
  (check-type if-exists (member :error :warn :ignore))
  (setf target-package (find-package target-package))
  (do-external-symbols (symbol source-package)
    (when (or (not filter)
              (funcall filter symbol))
      ;; do take care of the symbol nil: (list nil)!
      (block importing-one-symbol
        (let ((symbol (or symbol (list nil))))
          (when (and (symbolp symbol)
                     (find-symbol (symbol-name symbol) target-package))
            (ecase if-exists
              (:error
               ;; let the IMPORT call below signal an error for us with some useful restarts
               (import symbol target-package))
              (:warn
               (warn 'simple-style-warning "Symbol ~S already exists in package ~A. Using ~S, the already present one."
                     symbol target-package (find-symbol (symbol-name symbol) target-package))
               (import symbol target-package))
              (:ignore )))
          (export symbol target-package))))))

(defun export-external-symbols-of-used-packages (package &key filter)
  (dolist (used-package (package-use-list (find-package package)))
    (export-external-symbols used-package package :filter filter)))

(export-external-symbols-of-used-packages :hu.dwim.common)
