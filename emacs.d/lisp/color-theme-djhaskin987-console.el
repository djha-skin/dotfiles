(require 'color-theme)
(defun color-theme-djhaskin987-console ()
  "dark color theme created by djcb, Jan. 2009. Modified by Dan Haskin, Apr. 2012."
  (interactive)
  (color-theme-install
    '(color-theme-djhaskin987-console
       ((foreground-color . "white")
         (background-color . "default") 
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))
       

       (font-lock-string-face ((t (:foreground "red"))))
       (font-lock-constant-face ((t (:bold t :foreground "red"))))
       (font-lock-negation-char-face ((t (:foreground "red"))))

       (font-lock-keyword-face ((t (:bold t :foreground "yellow"))))
       (font-lock-builtin-face ((t (:foreground "yellow"))))

       (font-lock-type-face ((t (:italic t :foreground "green"))))
       (font-lock-function-name-face ((t (:bold t :foreground "magenta"))))
       (font-lock-reference-face ((t (:italic t :foreground "magenta"))))
       (font-lock-variable-name-face ((t (:bold t :foreground "magenta"))))

       (font-lock-doc-face ((t (:bold t :foreground "blue"))))
       (font-lock-doc-string-face ((t (:bold t :italic t :foreground "blue"))))
       (font-lock-comment-face ((t (:bold t :foreground "cyan"))))
       (font-lock-comment-delimiter-face ((t (:foreground "cyan"))))

       (font-lock-preprocessor-face ((t (:foreground "red"))))

       (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
                                     :foreground "yellow" :background "red"))))
       (hl-line ((t (:background "white" ))))
       (mode-line ((t (:foreground "black" :background "white"))))
       (region ((t (:foreground nil :background "magenta"))))
       (show-paren-match-face ((t (:bold t :foreground "yellow" 
                                    :background "red")))))))
(provide 'color-theme-djhaskin987-console)
