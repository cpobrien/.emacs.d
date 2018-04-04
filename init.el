;; And Stallman said, Let there be light: and there was light.
(package-initialize)
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

(defvar use-package-always-ensure t) ;; I'd like my dependencies to install by default

(require 'use-package)

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
(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil))
(use-package smart-mode-line-powerline-theme)
(use-package buttercup)
(use-package rust-mode)
(use-package smart-mode-line)
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
  (ivy-mode))
(use-package swiper
  :config
  (global-set-key (kbd "C-s") 'swiper))
(use-package haskell-mode)
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (doom-themes-org-config))
(use-package solaire-mode)
(use-package hlinum
  :config
  (hlinum-activate))
(use-package olivetti)

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
(global-hl-line-mode)
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)

;; flycheck
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; my theme
(load-theme 'doom-dracula)

;; emacs function dumping ground
;; open init.el
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; solaire-mode
(add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)
(add-hook 'ediff-prepare-buffer-hook #'solaire-mode)
(add-hook 'after-revert-hook #'turn-on-solaire-mode)
(add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)
(solaire-mode-swap-bg)

;; fix path


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
    (olivetti hlinum nlinum solaire-mode doom-themes smart-mode-line-powerline-theme dracula-theme darcula-theme counsel haskell-mode swiper ivy buttercup cargo exec-path-from-shell exec-path-from-shell-initialize flycheck-rust rust-mode flycheck use-package smart-mode-line magit)))
 '(sml/mode-width
   (if
       (eq
	(powerline-current-separator)
	(quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote sml/global)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active2)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
