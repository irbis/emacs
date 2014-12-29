;; Emacs configuration file
;; 
;; Just checkout somewhere and link ~/.emacs to it. For development and test
;; runs 'emacs -q -l path-to-init-emacs.el'
;;

;; under gentoo
(require 'site-gentoo nil 1)
; Other method to check existence and run:
;;;(if (member 'site-gentoo features)
;;;    (require 'site-gentoo))

;; sudo support
(require 'tramp)

;; color theme support
(when (require 'color-theme nil 1)
  (color-theme-initialize)
  (color-theme-calm-forest))

;; Set frame size in the X-Windows system
(if window-system
    (set-frame-size (selected-frame) 100 40))

;; Base font to show content
(set-face-attribute 'default nil :font "DejaVu Sans Mono-11")
;(set-face-attribute 'default nil :font "Inconsolata-14")
;(set-face-attribute 'default nil :font "Anonymous Pro-14")

;; common settings
;; variables
; turn off startup message
(custom-set-variables
 '(inhibit-startup-message t)
 '(initial-buffer-choice nil)
 '(indent-tabs-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(nxml-slash-auto-complete-flag 1)
; calendar variables
 '(calendar-latitude 49.9)
 '(calendar-longitude 36.3)
 '(calendar-location-name "Kharkiv, UA"))


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

