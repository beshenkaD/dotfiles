;; ========= Package settings =========
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(package-install 'use-package)

(require 'use-package)
(setq use-package-always-ensure t)

;; ========= Common Settings =========
(setq make-backup-files nil)

;; Comments
(use-package evil-commentary)
(evil-commentary-mode)

;; Tabs
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
(setq-default indent-tabs-mode nil)

;; ========= Ui configuration ==========
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(setq visible-bell nil)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Appearance
(use-package doom-themes
	     :init (load-theme 'doom-one t))

(use-package doom-modeline
	     :init (doom-modeline-mode 1)
	     :custom ((doom-modeline-height 12)))

(use-package all-the-icons)

(use-package emojify
	     :hook (after-init . global-emojify-mode))

;; ========= Keybindings =========
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(setq evil-want-keybinding nil)
(use-package evil
	     :init
	     (setq evil-want-integration t)
	     (setq evil-want-C-u-scroll t)
	     (setq evil-want-C-i-jump nil)
	     (setq evil-undo-system 'undo-tree)
	     :config
	     (evil-mode 1)
	     (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
	     (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

	     ;; Use visual line motions even outside of visual-line-mode buffers
	     (evil-global-set-key 'motion "j" 'evil-next-visual-line)
	     (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

	     (evil-set-initial-state 'messages-buffer-mode 'normal)
	     (evil-set-initial-state 'dashboard-mode 'normal))

(evil-ex-define-cmd "q" 'kill-buffer-and-window)
(use-package evil-collection
	     :after evil
	     :config
	     (evil-collection-init))

;; ========= Packages =========
(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

;; ======== Code =======
;; Complete
(use-package company)

;; Flymake
(use-package flymake-diagnostic-at-point
  :after flymake
  :custom
  (flymake-diagnostic-at-point-timer-delay 0.1)
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

;; LSP
(use-package eglot)

;; Golang
(use-package go-mode)
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'company-mode)

(defun eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
(add-hook 'go-mode-hook #'eglot-format-buffer-on-save)

(setq-default eglot-workspace-configuration
    '((:gopls .
        ((staticcheck . t)))))

;; ======== Functions ========
(defun bs/bash ()
  "Start a terminal emulator in a new window."
  (interactive)
  (split-window-vertically)
  (enlarge-window 5)
  (other-window 1)
  (ansi-term (executable-find "bash")))

;; ==========================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(undo-tree evil-nerd-commenter company lsp-ui lsp-mode which-key doom-modeline all-the-icons doom-themes evil-collection evil general use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
