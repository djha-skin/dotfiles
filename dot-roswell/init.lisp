(require "asdf")

(defun dir-pkg (pkg)
  (loop for s being the external-symbols of pkg do (print s)))
