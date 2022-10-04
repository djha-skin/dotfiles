(require 'color-theme)
(defun color-theme-rainbow-brite ()
  "dark color theme created by djcb, Jan. 2009."
  (interactive)
  (color-theme-install
    '(color-theme-rainbow-brite
       ((foreground-color . "#ffffff")
         (background-color . "#000000") 
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))
       

       (font-lock-string-face ((t (:foreground "#ff0088"))))
       (font-lock-constant-face ((t (:foreground "#ff0000"))))
       (font-lock-negation-char-face ((t (:foreground "#ff8800"))))
       (font-lock-keyword-face ((t (:foreground "#ffff00"))))
       (font-lock-builtin-face ((t (:foreground "#cccc00"))))
       (font-lock-type-face ((t (:foreground "#88ff00"))))
       (font-lock-function-name-face ((t (:foreground "#00ff00"))))
       (font-lock-reference-face ((t (:foreground "#00ff88"))))
       (font-lock-variable-name-face ((t (:foreground "#00ffff"))))
       (font-lock-doc-face ((t (:foreground "#0088ff"))))
       (font-lock-preprocessor-face ((t (:foreground "#0000ff"))))
       (font-lock-doc-string-face ((t (:foreground "#8800ff"))))
       (font-lock-comment-face ((t (:foreground "#ff00ff"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#cc00cc"))))
       (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
                                     :foreground "yellow" :background "red"))))
       (hl-line ((t (:background "#112233"))))
       (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
       (region ((t (:foreground nil :background "#555555"))))
       (show-paren-match-face ((t (:bold t :foreground "#ffff00" 
                                    :background "#ff0000")))))))
(provide 'color-theme-rainbow-brite)
