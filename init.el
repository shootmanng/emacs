(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("47db50ff66e35d3a440485357fb6acb767c100e135ccdf459060407f8baea7b2" default))
 '(package-selected-packages
   '(sage-shell-mode pdf-tools treemacs helpful which-key use-package soothe-theme solarized-theme rainbow-delimiters ivy-rich doom-themes doom-modeline counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;remove default emacs buffer and messages

(setq inhibit-startup-message t)


(scroll-bar-mode -1)        ;disable visible scroll bar
(tool-bar-mode -1)          ;disable the toolbar
(tooltip-mode -1)           ;disable tool tips
(set-fringe-mode 10)        ;Breathing room
(menu-bar-mode -1)          ;Disable menu bar
(setq visible-bell t)       ;visible bell

;;Make frame transparant and maximized

(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;Theme

(load-theme 'doom-palenight)

;;load package repositories

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https:elpa.gnu.org/packages")))

;;Use esc as quit

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;Check that the package list is full

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;;Check that use-package is installed

(unless (package-installed-p 'usepackage)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;Show line numbers
(column-number-mode 1)
(global-display-line-numbers-mode t)

;;Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode(lambda () (display-line-numbers-mode 0))))

;;Install counsel/Ivy for autofilling commands

(use-package ivy
  :bind (("C-s" . swiper))
  :config
  (ivy-mode 1))

;;doom modeline

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 10))

;;rainbow delimiters for programming modes

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;enable which key, gives summary of options on mode line

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

;;Ivy rich and counsel which give info in menus

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; map M-x to counsel-M-x which has nice descriptions

(use-package counsel
  :bind (("M-x" . counsel-M-x)))

;;helpful package to help noobs like me

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;;require pdftools to be default instead of docview

(add-hook 'doc-view-mode-hook 'pdf-tools-install) 

;;fit to page

(setq-default pdf-view-display-size 'fit-page)

;; automatically annotate highlights

(setq pdf-annot-activate-created-annotations t)

;;start treemacs

(use-package treemacs)
(add-hook 'emacs-startup-hook 'treemacs)

;;SageMath

(require 'sage-shell-mode)
(sage-shell:define-alias)
