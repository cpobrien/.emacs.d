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

(set-frame-font "SF Mono 12" nil t)
(add-hook 'elfeed-show-mode-hook
	  (lambda () (buffer-face-set "SF Mono 12")))


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

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
(global-linum-mode t)
(ivy-mode)
(ido-mode 1)
(show-paren-mode 1)
(fci-mode 1)

(setq linum-format " %s ")
(set-fringe-mode 0)
(setq git-commit-fill-column 80)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(set-face-attribute 'mode-line nil
                    :box '(:width 0))
(global-set-key (kbd "C-c c") 'find-user-init-file)
(global-set-key (kbd "C-c g") 'goto-line-indentation)
(global-set-key (kbd "C-c r") 'reload-emacs)
(global-set-key (kbd "C-b") 'switch-to-buffer)
(global-set-key [M-down] 'end-of-defun)

(add-hook 'org-mode-hook 'my-org-mode-hook)
(add-hook 'eshell-mode-hook 'my-eshell-hook)
(add-hook 'markdown-mode-hook 'my-markdown-hook)
(add-hook 'c++-mode-hook 'my-c++-hook)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode);

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
  (local-set-key (kbd "M-p") 'backward-same-level)
  (local-set-key (kbd "M-n") 'forward-same-level)
  (local-set-key (kbd "C-c 3") 'org-update-statistics-cookies)
  (local-set-key (kbd "<return>") ‘org-return-indent)
  (add-hook 'after-save-hook 'custom_org_auto_check nil 'make-it-local))

(defun my-eshell-hook ()
  (linum-mode 0))

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
  (local-set-key (kbd "C-c C-c") 'cpp-run))

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
(global-set-key (kbd "C-x C-k") 'kill-buffer-and-window)
(global-set-key (kbd "C-d") 'set-mark-command)

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

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defadvice keyboard-escape-quit (around my-keyboard-escape-quit activate)
  (let (orig-one-window-p)
    (fset 'orig-one-window-p (symbol-function 'one-window-p))
    (fset 'one-window-p (lambda (&optional nomini all-frames) t))
    (unwind-protect
        ad-do-it
      (fset 'one-window-p (symbol-function 'orig-one-window-p)))))

(setq ido-ignore-extensions t)
(setq ido-ignore-buffers '("\\*Messages\\*"))

(windmove-default-keybindings)
(setq org-replace-disputed-keys t)
(global-set-key (kbd "C-x w") 'elfeed)
(global-set-key (kbd "C-x j") 'join-line)
(setq elfeed-feeds
      '("https://danluu.com/atom.xml"
	"http://nullprogram.com/feed/"
	"https://lobste.rs/rss"
	"http://sachachua.com/blog/feed/"
	"https://xkcd.com/rss.xml"
	"https://jvns.ca/atom.xml"
	"https://eli.thegreenplace.net/feeds/all.atom.xml"))

(load-theme 'gruvbox-dark-hard)
