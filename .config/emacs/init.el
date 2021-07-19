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

;; Neotree
(use-package neotree
  :ensure t
  :bind ("<f8>" . 'neotree-toggle)
  :init
  ;; slow rendering
  (setq inhibit-compacting-font-caches t)

  ;; set icons theme
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; Every time when the neotree window is opened, let it find current file and jump to node
  (setq neo-smart-open t)

  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically
  ; (setq projectile-switch-project-action 'neotree-projectile-action)

  ;; show hidden files
  (setq-default neo-show-hidden-files t))

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

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

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
(use-package ivy
	     :diminish
	     :bind (("C-s" . swiper)
		    :map ivy-minibuffer-map
		    ("TAB" . ivy-alt-done)
		    ("C-l" . ivy-alt-done)
		    ("C-j" . ivy-next-line)
		    ("C-k" . ivy-previous-line)
		    :map ivy-switch-buffer-map
		    ("C-k" . ivy-previous-line)
		    ("C-l" . ivy-done)
		    ("C-d" . ivy-switch-buffer-kill)
		    :map ivy-reverse-i-search-map
		    ("C-k" . ivy-previous-line)
		    ("C-d" . ivy-reverse-i-search-kill))
	     :config
	     (ivy-mode 1))

(use-package ivy-rich
	     :init
	     (ivy-rich-mode 1))

(use-package counsel
	     :bind (("C-M-j" . 'counsel-switch-buffer)
		    :map minibuffer-local-map
		    ("C-r" . 'counsel-minibuffer-history))
	     :config
	     (counsel-mode 1))

;; ======== Code =======
;; Complete
(use-package company)

(use-package company-box
	     :hook (company-mode . company-box-mode))

;; Flymake
(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

;; Eldoc
(use-package eldoc-box)
(add-hook 'eglot--managed-mode-hook #'eldoc-box-hover-mode t)

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
 '(package-selected-packages
   '(undo-tree evil-nerd-commenter company-box company lsp-ui lsp-mode which-key doom-modeline all-the-icons doom-themes evil-collection evil general use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
