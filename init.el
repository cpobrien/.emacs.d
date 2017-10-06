(setq package-archives
      '(("elpy" . "http://jorgenschaefer.github.io/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "Http://orgmode.org/elpa/")))

;; Secret corporate emacs goes here
(if (file-exists-p "~/.emacs.d/corp.el")
    (load-file "~/.emacs.d/corp.el"))

(package-initialize)
(setq evil-want-C-u-scroll t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(require 'package)
(require 'rainbow-delimiters)
(require 'linum-relative)
(require 'dashboard)
(require 'evil)

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

(set-frame-font "Hack 12" nil t)

;; All mode preferences
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(global-linum-mode t)
(linum-relative-on)
(ivy-mode)
(evil-mode)
(server-mode 1)
(ido-mode 1)
(show-paren-mode 1)
(nyan-mode 1)
(nyan-start-animation)
(nyan-toggle-wavy-trail)
(fci-mode 1)
(evil-set-initial-state 'eshell-mode 'emacs)
(dashboard-setup-startup-hook)

(setq dashboard-startup-banner 'logo)
(setq linum-relative-format " %s ")

(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(load-theme 'base16-railscasts t)
(setq per-buffer-theme/default-theme 'base16-railscasts)
(setq per-buffer-theme/themes-alist
	    '(((:theme . base16-one-light)
	       (:modes dashboard-mode
		       erc-mode
		       erc-list-menu-mode
		       org-mode
		       markdown-mode))
	      ((:theme . gruvbox-dark-hard)
	       (:modes c-mode c++-mode))
	      ((:theme . base16-monokai)
	       (:modes js-mode
		       jsx-mode
		       ruby-mode
		       css-mode
		       inf-ruby-mode))
	      ((:theme . base16-greenscreen)
	       (:modes sh-mode))
	      ((:theme . idea-darkula)
	       (:modes java-mode))))
(setq per-buffer-theme/timer-idle-delay 0.1)
(per-buffer-theme/enable)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-c c") 'find-user-init-file)
(global-set-key (kbd "C-c g") 'goto-line-indentation)
(global-set-key (kbd "C-c r") 'reload-emacs)
(global-set-key (kbd "C-p") 'clipboard-yank)
(global-set-key (kbd "C-l") 'switch-to-buffer)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key [M-down] 'end-of-defun)

(add-hook 'org-mode-hook 'my-org-mode-hook)
(add-hook 'eshell-mode-hook 'my-eshell-hook)
(add-hook 'ruby-mode-hook 'my-ruby-hook)
(add-hook 'markdown-mode-hook 'my-markdown-hook)
(add-hook 'c++-mode-hook 'my-c++-hook)
(add-hook 'c-mode-hook 'my-c-hook)
(add-hook 'erc-mode-hook 'my-erc-hook)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode);
(add-hook 'dashboard-mode-hook 'turn-off-fci-mode)
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

(defun my-org-mode-hook ()
  (local-set-key (kbd "<M-return>") 'org-make-subelement)
  (local-set-key (kbd "C-c a") 'org-todo-list)
  (local-set-key (kbd "C-c t") 'org-todo))

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
  (setq buffer-face-mode-face '(:family "Perfect DOS VGA 437"
				:height 145))
  (buffer-face-mode))

(defun face-mode-variable ()
  (interactive)
  (setq buffer-face-mode-face '(:family "SF Pro Text"
				:height 125))
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
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-global)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

(global-set-key (kbd "M-˙") 'beginning-of-line)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-b") 'open-list-and-change)
(global-set-key (kbd "C-x k") 'kill-buffer-and-window)

(when (memq window-system '(mac ns))
  (setq ns-use-srgb-colorspace nil))

(require 'telephone-line-config)
(setq telephone-line-primary-left-separator 'telephone-line-cubed-left
      telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
      telephone-line-primary-right-separator 'telephone-line-cubed-right
      telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
(setq telephone-line-height 24
      telephone-line-evil-use-short-tag t)
(telephone-line-evil-config)

(setq dashboard-items '((recents  . 10)
			(agenda . 5)))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq tramp-default-method "ssh")

