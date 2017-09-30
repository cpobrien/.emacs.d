(setq package-archives
      '(("elpy" . "http://jorgenschaefer.github.io/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "Http://orgmode.org/elpa/")))

(package-initialize)

(setq evil-want-C-u-scroll t)

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

(set-frame-font "Menlo 12" nil t)

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
(load-theme 'solarized-light t)
(setq per-buffer-theme/default-theme 'solarized-light)
(setq per-buffer-theme/themes-alist
	    '(((:theme . adwaita)
	       (:modes dashboard-mode
		       erc-mode
		       erc-list-menu-mode
		       org-mode markdown-mode))
	      ((:theme . gruvbox-dark-hard)
	       (:modes c-mode c++-mode))
	      ((:theme . base16-monokai)
	       (:modes js-mode
		       jsx-mode
		       ruby-mode
		       inf-ruby-mode))
	      ((:theme . base16-greenscreen)
	       (:modes sh-mode))
	      ((:theme . whiteboard)
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

(add-hook 'ruby-mode-hook 'my-ruby-hook)
(add-hook 'markdown-mode-hook 'my-markdown-hook)
(add-hook 'c++-mode-hook 'my-c-hook)
(add-hook 'c-mode-hook 'my-c-hook)
(add-hook 'org-mode-hook 'my-erc-hook)
(add-hook 'erc-mode-hook 'my-erc-hook)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode);
(add-hook 'dashboard-mode-hook 'Turn-off-fci-mode)
(add-hook 'sh-mode-hook 'my-sh-hook)

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

 '(ansi-term-color-vector
   ["#ffffff" "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#c5c8c6"] t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1c2023" "#c7ae95" "#95c7ae" "#aec795" "#ae95c7" "#c795ae" "#ae95c7" "#c7ccd1"])
 '(ansi-term-color-vector
   [unspecified "#1c2023" "#c7ae95" "#95c7ae" "#aec795" "#ae95c7" "#c795ae" "#ae95c7" "#c7ccd1"] t)
 '(custom-safe-themes
   (quote
    ("350dc341799fbbb81e59d1e6fff2b2c8772d7000e352a5c070aa4317127eee94" "36746ad57649893434c443567cb3831828df33232a7790d232df6f5908263692" "146061a7ceea4ccc75d975a3bb41432382f656c50b9989c7dc1a7bb6952f6eb4" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "ef04dd1e33f7cbd5aa3187981b18652b8d5ac9e680997b45dc5d00443e6a46e3" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "25c242b3c808f38b0389879b9cba325fb1fa81a0a5e61ac7cae8da9a32e2811b" "456bf5cfc3477da926015fb43b28d91bb31632003cfb73f0362c2ff20f885046" "4a91a64af7ff1182ed04f7453bb5a4b0c3d82148d27db699df89a5f1d449e2a4" "b9a06c75084a7744b8a38cb48bc987de10d68f0317697ccbd894b2d0aca06d2b" "760ce657e710a77bcf6df51d97e51aae2ee7db1fba21bbad07aab0fa0f42f834" "82b67c7e21c3b12be7b569af7c84ec0fb2d62105629a173e2479e1053cff94bd" "44c566df0e1dfddc60621711155b1be4665dd3520b290cb354f8270ca57f8788" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142" "5df96b0536c5d334c1e083f62f5cc7a1e28d056bea82a2eb0d049bc08beadc78" "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b" "c614d2423075491e6b7f38a4b7ea1c68f31764b9b815e35c9741e9490119efc0" "25c06a000382b6239999582dfa2b81cc0649f3897b394a75ad5a670329600b45" "a4c9e536d86666d4494ef7f43c84807162d9bd29b0dfd39bdf2c3d845dcc7b2e" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" default)))
 '(eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim")
 '(fci-rule-color "#3E4451")
 '(package-selected-packages
   (quote
    (solarized-theme inf-ruby auto-complete restart-emacs moe-theme nyan-mode magit dashboard resize-window fill-column-indicator clevercss idea-darkula-theme github-modern-theme linum-relative jsx-mode rainbow-delimiters zenburn-theme ccc bury-successful-compilation projectile gruvbox-theme colemak-evil zenburn counsel swiper ivy per-buffer-theme evil load-theme-buffer-local atom-one-dark-theme color-theme-buffer-local autodisass-java-bytecode json-mode org markdown-mode base16-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(quote (package-selected-packages (quote (base16-theme)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

