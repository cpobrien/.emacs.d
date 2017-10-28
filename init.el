(setq package-archives
      '(("elpy" . "http://jorgenschaefer.github.io/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "Http://orgmode.org/elpa/")))

(require 'desktop)
(desktop-save-mode 1) 
(package-initialize)

;; Secret corporate emacs goes here
(if (file-exists-p "~/other_elisp/corp.el")
    (load-file "~/other_elisp/corp.el"))


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(invert-face 'default)

(use-package rainbow-delimiters)

(add-to-list 'default-frame-alist '(height . 48))
(add-to-list 'default-frame-alist '(width . 160))
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq org-agenda-files (list "~/work.org" "~/Google Drive/life.org"))

;; All mode preferences
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(global-linum-mode t)
(ivy-mode)
(ido-mode 1)(show-paren-mode 1)
(fci-mode 1)

(setq linum-format "%s ")
(setq git-commit-fill-column 80)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(set-face-attribute 'mode-line nil
                    :box '(:width 0))
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-c c") 'find-user-init-file)
(global-set-key (kbd "C-c g") 'goto-line-indentation)
(global-set-key (kbd "C-c r") 'reload-emacs)
(global-set-key (kbd "C-p") 'clipboard-yank)
(global-set-key (kbd "C-l") 'switch-to-buffer)
(global-set-key [M-down] 'end-of-defun)

(add-hook 'org-mode-hook 'my-org-mode-hook)
(add-hook 'eshell-mode-hook 'my-eshell-hook)
(add-hook 'ruby-mode-hook 'my-ruby-hook)
(add-hook 'markdown-mode-hook 'my-markdown-hook)
(add-hook 'c++-mode-hook 'my-c++-hook)
(add-hook 'c-mode-hook 'my-c-hook)
(add-hook 'erc-mode-hook 'my-erc-hook)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode);
(add-hook 'sh-mode-hook 'my-sh-hook)

(defun org-make-subelement ()
  (interactive)
  (org-insert-heading-respect-content)
  (org-demote-subtree)
  (end-of-line)
  (evil-insert 1))
(defun cpp-run ()
  (interactive)
  (save-buffer)
  (shell-command (format "clang %s && ./a.out" (buffer-file-name))))

;; TODO make these two respect current column position
(defun backward-same-level ()
  (interactive)
  (org-backward-element))

(defun forward-same-level ()
  (interactive)
  (org-forward-element))

(defun custom_org_auto_check()
  (org-update-checkbox-count t))

(defun my-org-mode-hook ()
  (local-set-key (kbd "<M-return>") 'org-make-subelement)
  (local-set-key (kbd "C-c a") 'org-todo-list)
  (local-set-key (kbd "C-c t") 'org-todo)
  (local-set-key (kbd "M-k") 'backward-same-level)
  (local-set-key (kbd "M-j") 'forward-same-level)
  (local-set-key (kbd "C-c 3") 'org-update-statistics-cookies)
  (local-set-key (kbd "<return>") ‘org-return-indent)
  (add-hook 'after-save-hook 'custom_org_auto_check nil 'make-it-local))

(defun my-eshell-hook ()
  (linum-mode 0))

(defun my-sh-hook ()
  (face-mode-old-school))

(defun my-ruby-hook ()
  (set-local-key (kbd "C-c s") 'run-rb))

(defun run-rb ()
  (interactive)
  (mark-whole-buffer)
  (ruby-send-block)
  (keyboard-quit))

(defun my-markdown-hook ()
  (linum-mode 0))

(defun my-c++-hook ()
  (local-set-key (kbd "C-c C-c") 'cpp-run)
  (face-mode-old-school))

(defun my-c-hook()
  (face-mode-old-school))

(defun my-erc-hook ()
  (face-mode-variable)
  (linum-mode 0))

(defun face-mode-old-school ()
  (interactive)
  (buffer-face-mode))

(defun face-mode-variable ()
  (interactive)
  (buffer-face-mode))

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file user-init-file))

(defun goto-line-indentation ()
  (interactive)
  (call-interactively 'goto-line)
  (back-to-indentation))

(defun reload-emacs ()
  (interactive)
  (save-buffer)
  (load-file "~/.emacs.d/init.el"))

(defun open-list-and-change ()
  (interactive)
  (list-buffers)
  (switch-to-buffer-other-window "*Buffer List*"))

(setq initial-frame-alist
      `((background-color . ,(face-background 'default))
	(foreground-color . ,(face-foreground 'default))
	(horizontal-scroll-bars . nil)
	(vertical-scroll-bars . nil)
	(menu-bar-lines . 0)
	(top . 50)      
	(left . 620)   
	(cursor-color . "red")
	(mouse-color . "green")))
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-b") 'open-list-and-change)
(global-set-key (kbd "C-x k") 'kill-buffer-and-window)

(when (memq window-system '(mac ns))
  (setq ns-use-srgb-colorspace nil))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq tramp-default-method "ssh")

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(global-set-key (kbd "C-c D")  'delete-file-and-buffer)
