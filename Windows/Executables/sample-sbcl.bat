;;;; @echo off
;;;; REM Inspired by https://stackoverflow.com/a/15885133 and https://stackoverflow.com/a/1295139
;;;; setlocal
;;;; set "me=%~f0"
;;;; sbcl --script "%me%" %*
;;;; goto :eof


(format t "Hello, World!~%")

;;;; Editor Modelines:
;;;;   - Emacs:
;;;;     - Local Variables:
;;;;     - c-basic-offset: 2
;;;;     - tab-width: 2
;;;;     - indent-tabs-mode: nil
;;;;     - mode: lisp
;;;;     - End:
;;;;   - Vim: set ft=lisp sw=2 ts=2 expandtab:
