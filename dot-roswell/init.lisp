(require "asdf")

(defun dir-pkg (pkg)
  (loop for s being the external-symbols of pkg do (print s)))

;;; The following lines added by ql:add-to-init-file:
;;#-quicklisp
;;(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
;;                                       (user-homedir-pathname))))
;;  (when (probe-file quicklisp-init)
;;    (load quicklisp-init)))
;;

(defun nvim (fname) (uiop:run-program (list "nvim-qt" fname)))

#+sbcl
(push #'nvim *ed-functions*)

#+windows
(progn
  (asdf:load-system "cffi")
  (pushnew (make-pathname
             :device "C"
             :directory '(:absolute
                           "Users"
                           "bhw"
                           "Code"
                           "cmake"
                           "bin"))
           cffi:*FOREIGN-LIBRARY-DIRECTORIES*)
  (pushnew (make-pathname
             :device "C"
             :directory '(:absolute
                           "Windows"
                           "System32"))
           cffi:*FOREIGN-LIBRARY-DIRECTORIES*))

#+(and ecl windows)
(progn
  (defpackage "C")
  (in-package "C")
  (defvar *CC* "cl.exe")
  (defvar *USER-CC-FLAGS* "")
  (export '*CC*)
  (export '*USER-CC-FLAGS*)
  (in-package #:cl-user)
  )
