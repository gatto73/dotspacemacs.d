(defun cscope//safe-project-root ()
  "Return project's root, or nil if not in a project."
  (and (fboundp 'projectile-project-root)
       (projectile-project-p)
       (projectile-project-root)))

(defun cscope/run-pycscope (directory)
  (interactive (list (file-name-as-directory
                      (read-directory-name "Run pycscope in directory: "
                                           (cscope//safe-project-root)))))
  (let ((default-directory directory))
    (shell-command
     (format "pycscope -R -f '%s'"
             (expand-file-name "cscope.out" directory)))))
