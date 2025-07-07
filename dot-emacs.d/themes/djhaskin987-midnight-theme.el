(deftheme djhaskin987-midnight
  "djhaskin987's midnight color theme")

(custom-theme-set-faces
 'djhaskin987-midnight

 ;; basic
 '(default ((t (:background "black" :foreground "white"))))
 '(region ((t (:background "#222222"))))
 '(fringe ((t (:background "#252323"))))
 '(border-color ((t (:background "black"))))
 '(highlight-current-line-face ((t (:background "grey12"))))
 '(hl-line ((t (:background "#252323"))))
 '(mouse ((t (:foreground "black" :background "DarkRed"))))
 '(cursor ((t (:foreground "black" :background "green"))))

 ;; diff mode
 '(diff-added ((t (:foreground "green"))))
 '(diff-header ((t (:foreground "purple"))))
 '(diff-removed ((t (:foreground "DarkRed"))))

 ;; dired
 '(dired-directory ((t (:foreground "green"))))
 '(dired-flagged ((t (:foreground "DarkRed"))))
 '(dired-header ((t (:foreground "purple"))))

 ;; latex
 '(font-latex-sedate-face ((t (:foreground "cyan"))))

 '(font-lock-builtin-face ((t (:foreground "SkyBlue"))))
 '(font-lock-comment-face ((t (:italic t :foreground "grey60"))))
 '(font-lock-comment-delimiter-face ((t (:forground "grey60"))))
 '(font-lock-constant-face ((t (:forground "#ff0000"))))
 '(font-lock-function-name-face ((t (:foreground "#ffa0ff"))))
 '(font-lock-keyword-face ((t (:foreground "Cyan"))))
 '(font-lock-preprocessor-face ((t (:foreground "#3232CC"))))
 '(font-lock-string-face ((t (:foreground "#ff00ff"))))
 '(font-lock-warning-face ((t (:bold t :foreground "Pink"))))
 '(font-lock-variable-name-face ((t (:foreground "DarkGoldenrod"))))
 '(font-lock-type-face ((t (:foreground "#008080")))) ;; dark cyan
 '(paren-face-match-light ((t (:background "grey30"))))
 '(show-paren-match ((t (:background "purple"))))
 '(show-paren-mismatch ((t (:background "red"))))
 '(highlight ((t (:background "#0000ff"))))

 ;; modeline
 '(modeline ((t (:background "black" :foreground "white"))))
 '(modeline-buffer-id ((t (:background "#000050" :foreground "white"))))
 '(modeline-mousable ((t (:background "#a5baf1" :foreground "black"))))
 '(modeline-mousable-minor-mode ((t (:background "#a5baf1" :foreground "#000000"))))

 '(primary-selection ((t (:background "#3B3B3F"))))
 '(isearch ((t (:background "#0000a0" :foreground "#ffffff"))))
 '(zmacs-region ((t (:background "#555577"))))
 '(secondary-selection ((t (:background "#545459"))))

 ;; flymake
 '(flymake-errline ((t (:background "LightSteelBlue" :foreground "#000000"))))
 '(flymake-warnline ((t (:background "LightSteelBlue" :foreground "#000000"))))

 ;; mini buffer
 '(minibuffer-prompt ((t (:bold t :background "DarkBlue" :foreground "#ffffff"))))

 '(underline ((t (:underline t))))
 '(italic ((t (:italic)))))

(provide-theme 'djhaskin987-midnight)
