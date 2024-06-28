(require '#:asdf)


#+ecl
(require '#:cmp)

#+(and win32 (not ocicl) (not quicklisp))
(when (probe-file #P"C:/Users/bhw/AppData/Local/ocicl/ocicl-runtime.lisp")
  (load #P"C:/Users/bhw/AppData/Local/ocicl/ocicl-runtime.lisp"))

;;; Any systems you install in C:/Users/bhw/AppData/Local/ocicl/
;;; will be available globally unless you comment out this line:
#+windows
(asdf:initialize-source-registry '(:source-registry :ignore-inherited-configuration (:tree #P"C:/Users/bhw/AppData/Local/ocicl/")))


;;; https://github.com/ocicl/ocicl.git
#-(or win32 ocicl)
(when (probe-file #P"/home/skin/.local/share/ocicl/ocicl-runtime.lisp")
  (load #P"/home/skin/.local/share/ocicl/ocicl-runtime.lisp"))
;;; Any systems you install in C:/Users/bhw/AppData/Local/ocicl/
;;; will be available globally unless you comment out this line:
#-windows
(asdf:initialize-source-registry '(:source-registry :ignore-inherited-configuration (:tree #P"/home/skin/local/share/ocicl/")))


;;; The following lines added by ql:add-to-init-file:
;;;#-quicklisp
;;;(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
;;;                                       (user-homedir-pathname))))
;;;  (when (probe-file quicklisp-init)
;;;    (load quicklisp-init)))
;;;

(defun nvim (fname)
  (multiple-value-bind
    (out err code)
    (uiop:run-program (list "nvim" fname)
                      :output :interactive
                      :input :interactive)
    (declare (ignore out)
             (ignore err))
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

(pushnew (uiop:getcwd) asdf:*central-registry*)