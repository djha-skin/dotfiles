(defun djha-skin-untab-to-tab-stop ()
  (interactive)
  (let ((original-column (current-column)))
    ;;(back-to-indentation)
    (let ((my-tab-stop-list (copy-tree (cdr tab-stop-list)))
          (destination-column 0)
          (next-column (car tab-stop-list))
          (at-column (current-column)))
      (while (and (> at-column next-column)
                  my-tab-stop-list)
        (setq destination-column next-column)
        (setq next-column (car my-tab-stop-list))
        (setq my-tab-stop-list (cdr my-tab-stop-list)))
      (when (not my-tab-stop-list)
        (setq destination-column 80))
      (let ((difference (- at-column destination-column)))
        (delete-backward-char difference)
        (move-to-column (- original-column difference))))))

(defun djha-skin-indent-rigidly ()
  (interactive)
  (indent-rigidly (region-beginning) (region-end) standard-indent))

(defun djha-skin-unindent-rigidly ()
  (interactive)
  (indent-rigidly (region-beginning) (region-end) (- standard-indent)))

(defun djha-skin-clear-kill-ring ()
  (interactive)
  (progn (setq kill-ring nil) (garbage-collect)))

(provide 'djha-skin-clear-kill-ring)
(provide 'djha-skin-untab-to-tab-stop)
(provide 'djha-skin-unindent-rigidly)
(provide 'djha-skin-indent-rigidly)
