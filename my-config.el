;; System specific configurations

(let (my-magit-repository-dir)
  (setq my-magit-repository-dir '(("~/workspace/SVN_git/" . 1)
                                  ("~/.spacemacs.d/" . 0)
                                  ("~/.emacs.d/" . 0)))
  ;; Windows 10 on ThinkPad (home)
  (when (string= (system-name)
                 "DESKTOP-JB1H1FA")
    (setq my/GTD-directory (file-name-as-directory "~/Dropbox/GTD"))
    (setq magit-repository-directories my-magit-repository-dir))
  ;; Windows 10 on ZBook (work)
  (when (string= (system-name)
                 "NB-Andreoletti")
    (setq my/GTD-directory (file-name-as-directory "~/Documents/208-GTD"))
    (setq magit-repository-directories my-magit-repository-dir))
  ;; Ubuntu on ThinkPad (home)
  (when (string= (system-name)
                 "xut")
    (setq my/GTD-directory (file-name-as-directory "~/Dropbox/GTD"))
    (setq magit-repository-directories my-magit-repository-dir))
  ;; Kubuntu on ZBook (work)
  (when (string= (system-name)
                 "ZBook-andreoletti")
    (setq my/GTD-directory nil)
    (setq magit-repository-directories my-magit-repository-dir)))

;; General configuration
(setq-default tab-width 4)

;; Set "PATH" and "exec-path" for Windows to use msys64
(when (eq system-type 'windows-nt)
  (setenv "PATH"
          (concat "C:\\msys64\\mingw64\\bin"
                  ";"
                  "C:\\msys64\\usr\\bin"
                  ";"
                  (getenv "PATH")))
  (setq exec-path (append '("c:/msys64/mingw64/bin" "c:/msys64/usr/bin")
                          exec-path)))


;; Set "PATH" and "exec-path" for Windows to use Cygwin
;; (when (eq system-type 'windows-nt)
;;   (setenv "PATH"
;;           (concat
;;            "C:\\cygwin64\\usr\\local\\bin" ";"
;;            "C:\\cygwind64\\usr\\bin" ";"
;;            (getenv "PATH")))

;;   (setq exec-path (append exec-path
;;                           '("c:/cygwin64/usr/local/bin"
;;                             "c:/cygwin64/bin"))))


;; Set "PATH" and exec-path correctly to use GNU find instead of
;; "C:\Windows\System32\find.exe". This is not working for commands passed to
;; windows shell, for example find-name-dired. Move
;; "c:\ProgramData\chocolatey\bin\" before "C:\Windows\System32\find.exe" in
;; PATH instead.
;; (setenv "PATH"
;;         (concat
;;          "C:\\ProgramData\\chocolatey\\bin" ";"
;;          (getenv "PATH")))
;; 
;; (setq exec-path (append '("c:/ProgramData/chocolatey/bin") exec-path)))

;; dired configuration
(with-eval-after-load 'dired
  (setq dired-dwim-target t))

;; markdown configuration
(with-eval-after-load 'markdown-mode
  (add-hook 'markdown-mode-hook
            '(lambda ()
               (spacemacs/toggle-fill-column-indicator-on)
               (spacemacs/toggle-auto-fill-mode-on)))
  (when (eq system-type 'windows-nt)
    (setq markdown-command (concat
                            "C:/Users/gatto/AppData/Local/Pandoc/pandoc.exe"
                            " --from=markdown --to=html --quiet"
                            " --standalone --mathjax --highlight-style=pygments"))))

;; text-mode configuration
(with-eval-after-load 'text-mode
  (add-hook 'text-mode-hook
            '(lambda ()
               (spacemacs/toggle-visual-line-navigation-on))))

;; python configuration
(with-eval-after-load 'python
  (add-hook 'python-mode-hook
            '(lambda ()
               (spacemacs/toggle-fill-column-indicator-on)
               (spacemacs/toggle-auto-fill-mode-on))))

;; c++-mode configuration
(with-eval-after-load 'cc-mode
  (add-hook 'c++-mode-hook
            '(lambda ()
               (setq show-trailing-whitespace nil)
               (setq tab-width 4))))

;; c-mode configuration
(with-eval-after-load 'cc-mode
  (add-hook 'c-mode-hook
            '(lambda ()
               (setq show-trailing-whitespace nil)
               (setq tab-width 4))))

;; cmake-mode configuration
(with-eval-after-load 'cmake-mode
  (add-hook 'cmake-mode-hook
            '(lambda ()
               (spacemacs/toggle-line-numbers-on))))

;; elisp configuration
(with-eval-after-load 'elisp-mode
  (add-hook 'emacs-lisp-mode-hook
            '(lambda ()
               (spacemacs/toggle-fill-column-indicator-on)
               (spacemacs/toggle-auto-fill-mode-on))))



;; hunspell configuration
(with-eval-after-load "ispell"
  (add-to-list 'ispell-dictionary-alist
               '(("italiano" "[[:alpha:]]"
                  "[^[:alpha:]]"
                  "[']"
                  nil
                  ("-d" "it_IT")
                  nil
                  utf-8)
                 ("english" "[[:alpha:]]"
                  "[^[:alpha:]]"
                  "[']"
                  t
                  ("-d" "en_US")
                  nil
                  utf-8)))
  (when (eq system-type 'windows-nt)
    (add-to-list 'exec-path "C:/App/hunspell/bin"))
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary-alist ispell-dictionary-alist)
  (setq ispell-hunspell-dictionary-alist ispell-dictionary-alist)
  (setq ispell-dictionary "italiano"))
;; (setq ispell-personal-dictionary
;;       (concat (file-name-as-directory user-home-directory)
;;               "hunspell/hunspell_it_IT"))
;; ispell-set-spellchecker-params has to be called
;; before ispell-hunspell-add-multi-dic will work
;; (ispell-set-spellchecker-params)
;; (ispell-hunspell-add-multi-dic "it_IT,en_GB")
;; (setq ispell-dictionary "it_IT,en_GB")

;; org configuration for GTD
(setq my/GTD-file-name "journal.org")

(with-eval-after-load 'org
  (add-hook 'org-mode-hook
            '(lambda ()
               (spacemacs/toggle-fill-column-indicator-on)
               (spacemacs/toggle-auto-fill-mode-on)))
  (unless (null my/GTD-directory)
    (setq org-agenda-files (list my/GTD-directory)))
  (setq org-todo-keywords '((sequence "TODO(t)" "|" "CANCELED(c)" "DONE(d)"))))

;; Commands to open GTD file and directory
(defun my-open-GTD-file ()
  "Open my GTD file."
  (interactive)
  (find-file (concat my/GTD-directory my/GTD-file-name)))

(defun my-open-GTD-dir ()
  "Open my GTD directory."
  (interactive)
  (find-file my/GTD-directory))

(spacemacs/set-leader-keys "oj" 'my-open-GTD-file)
(spacemacs/set-leader-keys "od" 'my-open-GTD-dir)


;; Zone out after 1 min when idle
(setq dotspacemacs-zone-out-when-idle 60)

;;; Additional packages configuration

;; Atomic Chrome configuration
(require 'atomic-chrome)
(atomic-chrome-start-server)
(setq atomic-chrome-buffer-open-style 'full)
(setq atomic-chrome-default-major-mode 'text-mode)
(setq atomic-chrome-url-major-mode-alist '(("notebook" . python-mode)
                                           ("Trac" . tracwiki-mode)))

;; flycheck-popup-tip configuration
(require 'flycheck-popup-tip)
(custom-set-variables '(flycheck-popup-tip-error-prefix "* "))

(eval-after-load 'flycheck
  (flycheck-popup-tip-mode))


;; Solve problem of server non starting on Windows
(when (or (null (server-running-p))
          (string= (server-running-p)
                   ":other"))
  (if (string= (server-running-p)
               ":other")
      (server-force-stop))
  (server-start)
  (message "traccia: Server not running, started from my-config.el"))
