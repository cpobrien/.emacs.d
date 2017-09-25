(require 'package)
(setq package-archives
      '(("elpy" . "http://jorgenschaefer.github.io/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "Http://orgmode.org/elpa/")))
(package-initialize)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode t)
(require 'linum-relative)
(linum-relative-on)
(setq linum-format "%d ")
(fringe-mode 0)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)


(setq per-buffer-theme/default-theme 'atom-one-dark)
(setq per-buffer-theme/themes-alist
	    '(((:theme . adwaita)
	       (:modes erc-mode erc-list-menu-mode org-mode))
	      ((:theme . gruvbox-dark-hard)
	       (:modes c-mode c++-mode))
	      ((:theme . base16-monokai)
	       (:modes js-mode jsx-mode))))
(setq per-buffer-tHeme/timer-idle-delay 0.1)
(per-buffer-theme/enable)


(defvar sm/fixed-font-name "SF Mono")
(defvar sm/fixed-font-weight 'medium)

(setq explicit-shell-file-name "/usr/local/Cellar/zsh/5.3.1_1/bin/zsh")

(set-face-attribute
 'default nil
 :family sm/fixed-font-name
 :weight sm/fixed-font-weight)

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file user-init-file))

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(defun goto-line-indentation ()
  (interactive)
  (call-interactively 'goto-line)
  (back-to-indentation))

(defun reload-emacs ()
  (interactive)
  (save-buffer)
  (load-file "~/.emacs.d/init.el"))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(set-frame-size-according-to-resolution)
(setq fullscreen 800)
(setq fullheight 800)
(add-to-list 'default-frame-alist '(fullscreen . fullheight))
(load-theme 'base16-tomorrow-night t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-c c") 'find-user-init-file)
(global-set-key (kbd "C-c g") 'goto-line-indentation)
(global-set-key (kbd "C-c r") 'reload-emacs)
(global-set-key (kbd "C-p") 'clipboard-yank)

(global-set-key [M-up] 'beginning-of-defun)
(global-set-key [M-down] 'end-of-defun)

(add-hook 'c++-mode-hook 'my-c-hook)
(add-hook 'c-mode-hook 'my-c-hook)
(defun my-c-hook()
  (face-mode-old-school))

(add-hook 'org-mode-hook 'my-erc-hook)
(add-hook 'erc-mode-hook 'my-erc-hook)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode);
(defun my-erc-hook ()
  (face-mode-variable)
  (linum-mode 0))

(defun face-mode-old-school ()
  (interactive)
  (setq buffer-face-mode-face '(:family "Perfect DOS VGA 437" :height 145))
  (buffer-face-mode))

(defun face-mode-variable ()
  (interactive)
  "Set font to a variable width (proportional) fonts in current buffer"
  (setq buffer-face-mode-face '(:family "SF Pro Text" :height 125))
  (buffer-face-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#c5c8c6"])
 '(ansi-term-color-vector
   [unspecified "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#c5c8c6"])
 '(custom-safe-themes
   (quote
    ("aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142" "5df96b0536c5d334c1e083f62f5cc7a1e28d056bea82a2eb0d049bc08beadc78" "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b" "c614d2423075491e6b7f38a4b7ea1c68f31764b9b815e35c9741e9490119efc0" "25c06a000382b6239999582dfa2b81cc0649f3897b394a75ad5a670329600b45" "a4c9e536d86666d4494ef7f43c84807162d9bd29b0dfd39bdf2c3d845dcc7b2e" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" default)))
 '(fci-rule-color "#3E4451")
 '(package-selected-packages
   (quote
    (linum-relative jsx-mode rainbow-delimiters zenburn-theme ccc bury-successful-compilation projectile gruvbox-theme colemak-evil zenburn counsel swiper ivy per-buffer-theme evil load-theme-buffer-local atom-one-dark-theme color-theme-buffer-local autodisass-java-bytecode json-mode org markdown-mode base16-theme)))
 '(quote (package-selected-packages (quote (base16-theme)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))

(setq initial-frame-alist
      `((background-color . ,(face-background 'default))
        (foreground-color . ,(face-foreground 'default))
        (horizontal-scroll-bars . nil)
        (vertical-scroll-bars . nil)
        (menu-bar-lines . 0)
        (top . 50)      ;; This is overridden by my-center-frame later.
        (left . 620)        ;; This is overridden by my-center-frame later.
        (cursor-color . "red")
        (mouse-color . "green")))
(require 'package)
(package-initialize)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(ivy-mode 1)
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
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(load-theme 'atom-one-dark t)
(evil-mode)
(require 'rainbow-delimiters)
(linum-relative-mode)
