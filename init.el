
;; And Stallman said, Let there be light: and there was light.
(package-initialize)
(require 'package)
(require 'use-package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))
(setq use-package-always-ensure t) ;; I'd like my dependencies to install by default

;; minimize noise
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(fringe-mode '(8 . 0))
(fset 'yes-or-no-p 'y-or-n-p)
(setq custom-safe-themes t)
(setq make-backup-files nil) ;; that's what git is for :)

;; change default commands
(setq mac-command-modifier 'meta) ;; option is too far
(defvar ido-enable-flex-matching t)
(defvar ido-everywhere t)
(global-set-key (kbd "C-d") 'set-mark-command)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-c c") 'open-init-file)
(global-set-key (kbd "C-c r") 'eval-buffer)
(global-unset-key (kbd "M-c")) ;; stop making a mess
(ido-mode 1)

;; dependencies
(use-package magit)
(use-package org
  :config
  (setq org-src-fontify-natively t
	org-src-tab-acts-natively t)
  (add-hook 'org-mode-hook
	    (lambda ()
	      (interactive)
	      (auto-fill-mode))))
(use-package exec-path-from-shell)
(use-package smart-mode-line)
(use-package buttercup)
(use-package rust-mode)
(use-package flycheck
  :config
  (setq flycheck-global-modes '(emacs-lisp-mode c-mode rust-mode))
  (global-flycheck-mode))
(use-package flycheck-rust
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))
(use-package cargo)
(use-package ivy
  :config
  (ivy-mode)
  (global-set-key (kbd "M-x") 'counsel-M-x))
(use-package swiper
  :config
  (global-set-key (kbd "C-s") 'swiper))
(use-package haskell-mode)

;; erc
(defvar erc-hide-list '("JOIN" "PART" "QUIT"))

;; rust
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; fix shell
(exec-path-from-shell-initialize)

;; set dependency keybindings
(global-set-key (kbd "C-x g") 'magit-status)

;; line numbers
(defvar linum-format " %d ")
(global-linum-mode 1)

;; powerline
(sml/setup)

;; flycheck
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; emacs function dumping ground
;; open init.el
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; noise
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (counsel haskell-mode swiper ivy buttercup cargo exec-path-from-shell exec-path-from-shell-initialize flycheck-rust rust-mode flycheck use-package smart-mode-line magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
