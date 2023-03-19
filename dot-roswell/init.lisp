(require '#:asdf)

#+ecl
(require '#:cmp)

;;; The following lines added by ql:add-to-init-file:
;;#-quicklisp
;;(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
;;                                       (user-homedir-pathname))))
;;  (when (probe-file quicklisp-init)
;;    (load quicklisp-init)))
;;
(defun nvim (fname) 
  (multiple-value-bind (uiop:run-program (list "nvim-qt" fname))
    (out err code)
    (eql code 0)))

#+sbcl
(push #'nvim *ed-functions*)


#+ecl
(progn
  (defpackage "C")
  (in-package "C")
  (defvar *CC* "cl.exe")
  (defvar *USER-CC-FLAGS* "")
  (export 'C:*CC*)
  (export 'C:*USER-CC-FLAGS*)
  (in-package #:cl-user)
  )