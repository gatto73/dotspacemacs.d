(defun spacemacs/trac-ticket ()
  "Activate optimal setting to edit a Track ticket."
  (interactive)
  (spacemacs/toggle-visual-line-navigation-on)
  (spacemacs/toggle-fill-column-indicator-off)
  (spacemacs/toggle-auto-fill-mode-off))

(defun spacemacs/trac-wiki ()
  "Activate optimal setting to edit a Track wiki page."
  (interactive)
  (spacemacs/toggle-visual-line-navigation-off)
  (spacemacs/toggle-fill-column-indicator-on)
  (spacemacs/toggle-auto-fill-mode-on))

(add-hook 'tracwiki-mode-hook
          '(lambda ()
             (spacemacs/trac-ticket)
             (setq tab-width 4)))
