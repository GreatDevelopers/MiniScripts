;; Load plugins
(add-to-list 'load-path "~/.emacs.d/")

;; No splash screen
(setq inhibit-splash-screen t)
(set-fringe-mode '(0 . 0))
;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ; One line at a time
(setq mouse-wheel-progressive-speed nil)            ; Don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ; Scroll window under mouse
(setq scroll-step 1)                                ; Keyboard scroll one line at a time
(setq scroll-margin 4)                              ; Always 4 lines above/below cursor

;; Deactivate menu-bar, tool-bar and scroll-bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


(column-number-mode 1)
;;(global-linum-mode t)
;;(setq-default mode-line-format nil)
;;(set-window-fringes nil 0 0)

(setq frame-title-format "%b")
(show-paren-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(auto-save-mode -1)
;;(global-highlight-changes-mode t)
(setq default-truncate-lines -1)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-region-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-hl-line-mode t)
