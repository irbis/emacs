;; Emacs configuration file
;; 
;; Just checkout somewhere and link ~/.emacs to it. For development and test
;; runs 'emacs -q -l path-to-init-emacs.el'
;;

;;
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; under gentoo
;;(require 'site-gentoo nil 1)
; Other method to check existence and run:
;;;(if (member 'site-gentoo features)
;;;    (require 'site-gentoo))

;; Ido mode
(require 'ido)
(ido-mode t)

;; sudo support
(setq tramp-default-method "ssh")
(require 'tramp)

;; color theme support
(when (require 'color-theme nil 1)
  (color-theme-initialize)
  (color-theme-calm-forest))

;; Set frame size in the X-Windows system
(if window-system
    (set-frame-size (selected-frame) 100 40))

;; Define base font to show the content
(cond
 ((string= system-type "gnu/linux")
  ; other tests fonts under the linux: "Inconsolata-14" and "Anonymous Pro-14"
  (set-face-attribute 'default nil :font "DejaVu Sans Mono-11"))
 ((string= system-type "darwin")
  (set-face-attribute 'default nil :font "Menlo-14")  
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path (list "/usr/local/bin")))))


;; common settings
;; variables
; turn off startup message
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-latitude 49.9)
 '(calendar-location-name "Kharkiv, UA")
 '(calendar-longitude 36.3)
 '(compilation-scroll-output t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(nxml-slash-auto-complete-flag 1)
 '(package-selected-packages
   (quote
    (yaml-mode magit company-lsp yasnippet lsp-ui lsp-mode flycheck sbt-mode scala-mode use-package gnu-elpa-keyring-update)))
 '(tab-width 4)
 '(tool-bar-mode nil))


; modes and submodes
(display-time-mode)
(show-paren-mode)

;; bind modes to extentions
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.vm$" . html-mode))

;; TODO org mode settings
(setq org-todo-keyword-faces
      '(("INPROGRESS" . (:foreground "blue" :weight bold))
        ("DELAYED" . (:foreground "gray" :weight bold))))

;; Quick access to this file to edit
(set-register ?e '(file . "~/emacs/git-resources/init-emacs.el"))

;; calendar settings
(setq calendar-week-start-day 1
      calendar-day-name-array ["Вс" "Пн" "Вт" "Ср" "Чт" "Пт" "Сб"]
      calendar-month-name-array ["Январь" "Февраль" "Март" "Апрель" "Май" "Июнь" "Июль"
                                 "Август" "Сентябрь" "Октябрь" "Ноябрь" "Декабрь"])

;; magit settings
(global-set-key (kbd "C-x g") 'magit-status)

;; slime
;(setq inferior-lisp-program "/usr/bin/sbcl")
;(add-to-list 'load-path "/usr/share/emacs/site-list/slime")
;(require 'slime)
;(slime-setup)

;; Programming languages mode hooks
;; turn highlight mode globally
(global-hi-lock-mode())
(add-hook 'c++-mode-hook (lambda()
                           (turn-on-auto-fill)
                           (set-fill-column 80)))

(add-hook 'python-mode-hook (lambda()
                              (turn-on-auto-fill)
                              (set-fill-column 89)))

(add-hook 'java-mode-hook (lambda()
                              (turn-on-auto-fill)
                              (set-fill-column 100)))

(add-hook 'text-mode-hook (lambda()
                              (turn-on-auto-fill)
                              (set-fill-column 80)))

(add-hook 'yaml-mode-hook (lambda()
                            (turn-on-auto-fill)
                            (set-fill-column 80)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; scala meta, please check https://scalameta.org for details of installation
(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


;; Enable scala-mode and sbt-mode
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook (scala-mode . lsp)
  :config (setq lsp-prefer-flymake nil))

(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals
(use-package company-lsp)
