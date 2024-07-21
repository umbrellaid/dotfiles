;;----------------------------------------------------------------------------
;; Adjust garbage collection
;;----------------------------------------------------------------------------
(setq gc-cons-threshold (* 20 1024 1024))

;; ---------------------
;; Setup Load Path
;; ---------------------

(add-to-list 'load-path (expand-file-name "user" user-emacs-directory))

;; -----------------------
;; use-package
;; -----------------------
(setq load-prefer-newer t)              ; Don't load outdated byte code

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)
(use-package diminish)

;; -------------------
;; Initial Setup
;; -------------------
(tool-bar-mode -1)
(unless (display-graphic-p)
  (menu-bar-mode -1))

(setq frame-title-format '((:eval (buffer-name))" [%+] Emacs"))

;; -------------------
;; Undo-tree
;; -------------------
(use-package undo-tree
  :diminish undo-tree-mode
  ;; load undo tree or else won't start until redo triggered
  :defer 2
  :config
  (global-undo-tree-mode)
  (define-key undo-tree-visualizer-mode-map [remap left-char] 'undo-tree-visualize-switch-branch-left)
  (define-key undo-tree-visualizer-mode-map [remap right-char] 'undo-tree-visualize-switch-branch-right)
  (setq undo-tree-auto-save-history nil)
  :bind
  )

(use-package goto-chg)

(use-package evil
  :ensure t
  :config
  ;; (evil-mode 1)
  )

(global-hl-line-mode t) ;; This highlights the current line in the buffer

;; (use-package beacon ;; This applies a beacon effect to the highlighted line
;;   :ensure t
;;   :config
;;   (beacon-mode 1))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; -------------------
;; expand-region
;; -------------------
(use-package expand-region
  )

;; -------------------
;; avy
;; -------------------
(use-package avy
  )

;; -------------------
;; which-key
;; -------------------
(use-package which-key
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-popup-type 'frame)
  (which-key-mode)
  (which-key-setup-minibuffer)
  (set-face-attribute 'which-key-local-map-description-face nil
		      :weight 'bold)
  :ensure t)

(use-package helm
  :init
  (setq helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t)
  :config
  (helm-mode 1) ;; Most of Emacs prompts become helm-enabled
  (helm-autoresize-mode 1) ;; Helm resizes according to the number of candidates
  (global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers ( Emacs way )
  (define-key evil-ex-map "b" 'helm-buffers-list) ;; List buffers ( Vim way )
  (global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
  (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
  (global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
  (global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
  (global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
  (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to paste
  :ensure t)

;; -------------------
;; multiple-cursors
;; -------------------
;; TODO - Advice CUA-keyboard-quit to quit mc and rrm
(use-package multiple-cursors
  :init
  (custom-set-variables `(mc/always-run-for-all ,t))
  :config
  :bind
  )

;; Setup Splash Screen
(setq inhibit-startup-screen t)
(setq-default major-mode 'org-mode)
(setq-default initial-scratch-message ";; Emacs lisp scratch buffer.\n\n")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
    (load custom-file))

;; Place all local configuration options here

(if (equal window-system 'w32)
    ;; All the following code will be executed ONLY if window-system is 'w32
    (progn
      (setenv "HOME" "C:\\Users\\recordr\\AppData\\Roaming\\")
      (setenv "PATH" (concat (getenv "PATH") ":C:/ProgramData/chocoportable/bin"))
      (setq exec-path (append exec-path '("C:/ProgramData/chocoportable/bin")))
      ;; The rest are wrapped into progn to allow after-load to function
      (progn
        (with-eval-after-load "ispell"
          (add-to-list 'ispell-hunspell-dict-paths-alist '("en_US" "C:/Hunspell/en_US.aff")))
        (global-unset-key (kbd "<scroll>"))
        (global-set-key (kbd "<scroll>") 'ignore)
        (setq w32-scroll-lock-modifier nil)
        (setq ispell-program-name "hunspell")
        (setenv "LANG" "en_US")
        (setq ispell-dictionary "en_US")
        )
      ) ;; End of the progn
  ;; Code for when window-system is 'x (or anything other than 'w32)
  ;; Add what should be executed only when under X windows
  (if (equal window-system 'x)
      (progn
        ;; Your X11-specific configurations here
	(defun drr-dired-open-mpv ()
	  "In Dired, open the file at point with mpv."
	  (interactive)
	  (let ((file (dired-get-file-for-visit)))
	    (start-process "mpv" nil "mpv" file)))

	(add-hook 'dired-mode-hook
		  (lambda ()
		    (define-key dired-mode-map (kbd "M-RET") 'drr-dired-open-mpv)))

        ))
  ) ;; End of the main if

(use-package emacs
  :init
  (setq confirm-kill-processes nil)             ; Stop confirming the killing of processes
  (setq use-short-answers t)                      ; y-or-n-p makes answering questions faster
  (setq read-process-output-max (* 1024 1024))    ; Increase the amount of data which Emacs reads from the process
  (setq gc-cons-threshold 100000000)
  (setq lsp-idle-delay 0.500)
  )

(setq sentence-end-double-space nil)

;; In an emacs lisp scratch buffer you can run this code to double
;; check value of variable:
;; (message "Current fill-column value: %d" fill-column)
;; M-x display-fill-column-indicator-mode
;; to show vertical line at the fill-column
;; highlight text and press ALT-q to fill text to that width
(setq-default fill-column 80)

;; Default to y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

(setq visible-bell t)

(blink-cursor-mode 0)

(recentf-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(toggle-frame-maximized)

(when (equal window-system 'x)
  (setq python-shell-interpreter "/usr/bin/python3.12"))

;; Automatically create closing parenthesis/quote
(electric-pair-mode 1)

(use-package org
  )

;; Enable Visual Line Mode to wrap at fill column
(use-package visual-fill-column
  :config
  (add-hook 'visual-line-mode-hook #'visual-fill-column-mode))

(use-package spacious-padding
  :config
  ;; (require 'spacious-padding)

  ;; These is the default value, but I keep it here for visibility.
  (setq spacious-padding-widths
        '( :internal-border-width 15
           :header-line-width 4
           :mode-line-width 6
           :tab-width 4
           :right-divider-width 30
           :scroll-bar-width 8
           :fringe-width 8))

  ;; Read the doc string of `spacious-padding-subtle-mode-line' as it
  ;; is very flexible and provides several examples.
  (setq spacious-padding-subtle-mode-line
        `( :mode-line-active 'default
           :mode-line-inactive vertical-border))

  (spacious-padding-mode 1)

  ;; Set a key binding if you need to toggle spacious padding.
  ;; (define-key global-map (kbd "<f8>") #'spacious-padding-mode)
  )

;;; For packaged versions which must use `require'.
(use-package modus-themes
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        )

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  (modus-themes-with-colors
    (custom-set-faces
     `(fill-column-indicator ((,c :height 1.0 :background ,bg-inactive :foreground ,bg-inactive)))))

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi)

  )

(use-package fontaine
  :config
  (require 'fontaine)

  (setq fontaine-latest-state-file
        (locate-user-emacs-file "fontaine-latest-state.eld"))

  ;; Iosevka Comfy is my highly customised build of Iosevka with
  ;; monospaced and duospaced (quasi-proportional) variants as well as
  ;; support or no support for ligatures:
  ;; <https://github.com/protesilaos/iosevka-comfy>.
  (setq fontaine-presets
        '((small
           :default-family "CaskaydiaCove Nerd Font"
           :default-height 120
           :variable-pitch-family "Liberation Sans")
          (regular) ; like this it uses all the fallback values and is named `regular'
          (medium
           :default-weight semilight
           :default-height 160
           :bold-weight extrabold)
          (large
           :inherit medium
           :default-height 200)
          (presentation
           :default-height 260)
          (t
           ;; I keep all properties for didactic purposes, but most can be
           ;; omitted.  See the fontaine manual for the technicalities:
           ;; <https://protesilaos.com/emacs/fontaine>.
           :default-family "CaskaydiaCove Nerd Font"
           :default-weight regular
           :default-height 120

           :fixed-pitch-family nil ; falls back to :default-family
           :fixed-pitch-weight nil ; falls back to :default-weight
           :fixed-pitch-height 1.0

           :fixed-pitch-serif-family nil ; falls back to :default-family
           :fixed-pitch-serif-weight nil ; falls back to :default-weight
           :fixed-pitch-serif-height 1.0

           :variable-pitch-family "Liberation Sans"
           :variable-pitch-weight nil
           :variable-pitch-height 1.0

           :mode-line-active-family nil ; falls back to :default-family
           :mode-line-active-weight nil ; falls back to :default-weight
           :mode-line-active-height 0.9

           :mode-line-inactive-family nil ; falls back to :default-family
           :mode-line-inactive-weight nil ; falls back to :default-weight
           :mode-line-inactive-height 0.9

           :header-line-family nil ; falls back to :default-family
           :header-line-weight nil ; falls back to :default-weight
           :header-line-height 0.9

           :line-number-family nil ; falls back to :default-family
           :line-number-weight nil ; falls back to :default-weight
           :line-number-height 0.9

           :tab-bar-family nil ; falls back to :default-family
           :tab-bar-weight nil ; falls back to :default-weight
           :tab-bar-height 1.0

           :tab-line-family nil ; falls back to :default-family
           :tab-line-weight nil ; falls back to :default-weight
           :tab-line-height 1.0

           :bold-family nil ; use whatever the underlying face has
           :bold-weight bold

           :italic-family nil
           :italic-slant italic

           :line-spacing nil)))

  ;; Set the last preset or fall back to desired style from `fontaine-presets'
  ;; (the `regular' in this case).
  (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))

  ;; Persist the latest font preset when closing/starting Emacs and
  ;; while switching between themes.
  (fontaine-mode 1)

  ;; fontaine does not define any key bindings.  This is just a sample that
  ;; respects the key binding conventions.  Evaluate:
  ;;
  ;;     (info "(elisp) Key Binding Conventions")
  )

(if (equal window-system 'x)
    (progn
      (use-package greader
        :config
        (setq greader-espeak-rate 300))
      (use-package elfeed
        :config
        (setq elfeed-feeds
              '(
                )
              )
        )
      )
  )

(use-package treemacs
  :ensure t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") 'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-git-command-pipe           ""
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-max-git-entries            5000
          treemacs-no-png-images              nil
          treemacs-no-delete-other-windows    t
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-cursor                nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))

  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package evil-snipe
  :after evil
  :ensure t
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  (evil-define-key '(normal motion) evil-snipe-local-mode-map
    "s" 'evil-snipe-s
    "S" 'evil-snipe-S)

  (evil-define-key 'operator evil-snipe-local-mode-map
    "z" 'evil-snipe-s
    "Z" 'evil-snipe-S
    "x" 'evil-snipe-x
    "X" 'evil-snipe-X)

  (evil-define-key 'motion evil-snipe-override-local-mode-map
    "f" 'evil-snipe-f
    "F" 'evil-snipe-F
    "t" 'evil-snipe-t
    "T" 'evil-snipe-T)

  (when evil-snipe-override-evil-repeat-keys
    (evil-define-key 'motion map
      ";" 'evil-snipe-repeat
      "," 'evil-snipe-repeat-reverse))
  )

(use-package evil-surround
  :after evil
  :ensure t)

(use-package evil-numbers
  :after evil
  :ensure t)

(use-package evil-nerd-commenter
  :after evil
  :ensure t)

(use-package evil-visualstar
  :after evil
  :ensure t)

(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode)
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2)
  (global-set-key (kbd "C-c C-g") 'evil-escape)
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package toc-org
  )
(add-hook 'org-mode-hook 'toc-org-mode)

(define-key dired-mode-map (kbd "E")
            (defun open-window-manager ()
              "Open default system windows manager in current directory"
              (interactive)
              (save-window-excursion
                (if (equal window-system 'w32)
                    (async-shell-command "explorer .")
                  (if (equal window-system 'x)
                      (async-shell-command "caja ."))))))

(require 'flyspell)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(if (equal window-system 'w32)
    (defcustom ispell-common-dictionaries '("en_US") "List of dictionaries for common use" :group 'ispell)
  (defcustom ispell-common-dictionaries '("en_US") "List of dictionaries for common use" :group 'ispell))

(setq-default ispell-dictionary (car ispell-common-dictionaries))

(define-key flyspell-mode-map (kbd "C-x M-$")
            (defun flyspell-buffer-or-region ()
              (interactive)
              (if (region-active-p)
                  (flyspell-region (region-beginning) (region-end))
                (flyspell-buffer))))

(require 'ibuffer nil t)
;; ibuffer groups
(setq-default ibuffer-saved-filter-groups
              (quote (("default"
                       ("org"  (mode . org-mode))
                       ("dired" (mode . dired-mode))
                       ("D" (mode . d-mode))
                       ("C/C++" (or
                                 (mode . cc-mode)
                                 (mode . c-mode)
                                 (mode . c++-mode)))
                       ("Markdown" (mode . markdown-mode))
                       ("emacs" (name . "^\\*Messages\\*$"))
                       ("shell commands" (name . "^\\*.*Shell Command\\*"))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(use-package olivetti
  )

(when (equal window-system 'x)
  ;; place linux programs here
  (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
  (require 'mu4e)
  ;; use mu4e for e-mail in emacs
  (setq mail-user-agent 'mu4e-user-agent)

  (setq mu4e-drafts-folder "/gmail/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/gmail/[Gmail]/Sent Mail")
  (setq mu4e-trash-folder  "/gmail/[Gmail]/Trash")
  (setq mu4e-refile-folder "/gmail/[Gmail]/All Mail")

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  (setq mu4e-sent-messages-behavior 'delete)

  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)

  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.

  (setq mu4e-maildir-shortcuts
	'( (:maildir "/gmail/INBOX"              :key ?i)
	   (:maildir "/gmail/[Gmail]/Sent Mail"  :key ?s)
	   (:maildir "/gmail/[Gmail]/Trash"      :key ?t)
	   (:maildir "/gmail/[Gmail]/All Mail"   :key ?a)))

  (add-to-list 'mu4e-bookmarks
	       ;; ':favorite t' i.e, use this one for the modeline
	       '(:query "maildir:/inbox" :name "Inbox" :key ?i :favorite t))

  ;; allow for updating mail using 'U' in the main view:
  ;; (setq mu4e-get-mail-command "")

  ;; something about ourselves
  (setq
   user-mail-address "daverecor@gmail.com"
   user-full-name  "David Recor"
   message-signature
   (concat
    "David Recor"))

  ;; sending mail -- replace USERNAME with your gmail username
  ;; also, make sure the gnutls command line utils are installed
  ;; package 'gnutls-bin' in Debian/Ubuntu

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
	starttls-use-gnutls t
	smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
	smtpmail-auth-credentials
	'(("smtp.gmail.com" 587 "daverecor@gmail.com" nil))
	smtpmail-default-smtp-server "smtp.gmail.com"
	smtpmail-smtp-server "smtp.gmail.com"
	smtpmail-smtp-service 587)

  ;; alternatively, for emacs-24 you can use:
  ;;(setq message-send-mail-function 'smtpmail-send-it
  ;;     smtpmail-stream-type 'starttls
  ;;     smtpmail-default-smtp-server "smtp.gmail.com"
  ;;     smtpmail-smtp-server "smtp.gmail.com"
  ;;     smtpmail-smtp-service 587)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

  (add-to-list 'mu4e-headers-actions
	       '("View in browser" . mu4e-action-view-in-browser) t)
  )

;; sync flags between mu4e and mbsync
(setq mu4e-change-filenames-when-moving t)


(use-package casual-suite)

(use-package casual-calc
  :ensure t
  :bind (:map calc-mode-map ("C-o" . casual-calc-tmenu)))

(use-package casual-info
  :ensure t
  :bind (:map Info-mode-map ("C-o" . casual-info-tmenu)))

(use-package casual-dired
  :ensure t
  :bind (:map dired-mode-map ("C-o" . casual-dired-tmenu)))

(use-package casual-avy
  :ensure t
  :bind ("<f9>" . casual-avy-tmenu))

(use-package casual-isearch
  :ensure t
  :bind (:map isearch-mode-map ("<f2>" . casual-isearch-tmenu)))

(require 'ibuffer)
(use-package casual-ibuffer
  :ensure t
  :bind (:map ibuffer-mode-map
              ("C-o" . casual-ibuffer-tmenu)
              ("F" . casual-ibuffer-filter-tmenu)
              ("s" . casual-ibuffer-sortby-tmenu)))

(require 're-builder)
(use-package casual-re-builder
  :ensure t
  :bind (:map reb-mode-map
              ("C-o" . casual-re-builder-tmenu)))

(defun drr-insert-date-stamp-prefix ()
  "Inserts the current date in mm-dd-yyyy format, prefixed with 'Date: '."
  (interactive)
  (insert (format-time-string "Date: %m-%d-%Y")))

(defun drr-insert-date-stamp ()
  "Inserts the current date in mm-dd-yyyy format"
  (interactive)
  (insert (format-time-string "%m-%d-%Y")))

(defun drr-locate-current-file-in-explorer ()
  (interactive)
  (cond
   ;; In buffers with file name
   ((buffer-file-name)
    (shell-command (concat "start explorer /e,/select,\"" (replace-regexp-in-string "/" "\\\\" (buffer-file-name)) "\"")))
   ;; In dired mode
   ((eq major-mode 'dired-mode)
    (shell-command (concat "start explorer /e,\"" (replace-regexp-in-string "/" "\\\\" (dired-current-directory)) "\"")))
   ;; In eshell mode
   ((eq major-mode 'eshell-mode)
    (shell-command (concat "start explorer /e,\"" (replace-regexp-in-string "/" "\\\\" (eshell/pwd)) "\"")))
   ;; Use default-directory as last resource
   (t
    (shell-command (concat "start explorer /e,\"" (replace-regexp-in-string "/" "\\\\" default-directory) "\"")))))

(defun drr-my-reindent-file ()
  "Reindent the entire file and return to the original cursor position."
  (interactive)
  (let ((original-line (line-number-at-pos))
        (original-column (current-column)))
    (goto-char (point-min)) ; Move to the beginning of the file
    (mark-whole-buffer)    ; Select all lines
    (indent-region (point-min) (point-max)) ; Reindent the entire buffer (equivalent to C-M-\)
    (goto-line original-line) ; Return to the original line
    (move-to-column original-column nil) ; Return to the original column
    ))

(defun drr-condense-blank-lines ()
  "Condense multiple blank lines into a single blank line in the entire buffer."
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\n\n+" nil t)
    (replace-match "\n\n")))

(repeat-mode 1)

;; Define functions to enable and disable evil-mode
(defun enable-evil-mode ()
  "Enable evil mode and update the mode line indicator."
  (interactive)
  (evil-mode 1)
  (setq mode-line-format (list (default-value 'mode-line-format) " E-ON"))
  (force-mode-line-update))

(defun disable-evil-mode ()
  "Disable evil mode and update the mode line indicator."
  (interactive)
  (evil-mode -1)
  (setq mode-line-format (list (default-value 'mode-line-format) " E-OFF"))
  (force-mode-line-update))

(global-set-key (kbd "<f12>") 'enable-evil-mode)
(global-set-key (kbd "<f11>") 'disable-evil-mode)

(if (bound-and-true-p evil-mode)
    (setq mode-line-format (list (default-value 'mode-line-format) " E-ON"))
  (setq mode-line-format (list (default-value 'mode-line-format) " E-OFF")))

(add-hook 'emacs-startup-hook 'treemacs)

;; Set the default directory for Org mode files
(setq org-directory "~/MEGA/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; Set the default agenda files
(setq org-agenda-files (list (expand-file-name "todo.org" org-directory)
                             (expand-file-name "work.org" org-directory)
                             (expand-file-name "personal.org" org-directory)))

;; Optional: Configure the capture templates if you use org-capture
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (expand-file-name "todo.org" org-directory) "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("w" "Work" entry (file+headline (expand-file-name "work.org" org-directory) "Work")
         "* TODO %?\n  %i\n  %a")
        ("p" "Personal" entry (file+headline (expand-file-name "personal.org" org-directory) "Personal")
         "* TODO %?\n  %i\n  %a")))

;; Load org-agenda when Emacs starts
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; To customize settings for notmuch use the built in Emacs GUI customize-group
;; M-x customize-group RET notmuch RET
;; (autoload 'notmuch "notmuch" "notmuch mail" t)
;; (require 'notmuch)
(use-package notmuch
  )

(setq require-final-newline nil)
(use-package yasnippet
  :ensure t
  :init
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"  ;; personal snippets
	  ;; "/path/to/some/collection/"  ;; foo-mode and bar-mode snippet collection
	  ;; "/path/to/yasnippet/yasmate/snippets"  ;; the yasmate collection
          ))
  :config
  (define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
  (yas-global-mode 1))  ;; or M-x yas-reload-all if you've started YASnippet already

;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<the new key>") yas-maybe-expand)

;; ;;keys for navigation
;; (define-key yas-keymap [(tab)]       nil)
;; (define-key yas-keymap (kbd "TAB")   nil)
;; (define-key yas-keymap [(shift tab)] nil)
;; (define-key yas-keymap [backtab]     nil)
;; (define-key yas-keymap (kbd "<new-next-field-key>") 'yas-next-field-or-maybe-expand)
;; (define-key yas-keymap (kbd "<new-prev-field-key>") 'yas-prev)

;; Use w3m or a browser to view html
(setq mu4e-html2text-command 'mu4e-shr2text)
;; or:
;; (setq mu4e-html2text-command "html2text -utf8 -width 72")
;; or:
;; (setq mu4e-html2text-command 'mu4e-shr2text)
;; or:
;; (setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")

;; Choose the browser to open HTML emails
(setq mu4e-html2text-browser 'browse-url-generic)
(setq browse-url-generic-program "firefox")

(defun drr-copy-all-text ()
  "Selects all text in the buffer and copies it to the kill ring."
  (interactive)
  (mark-whole-buffer)
  (kill-ring-save (point-min) (point-max)))
(global-set-key (kbd "C-c v") 'drr-copy-all-text)

(defun drr-add-double-quotes-and-commas ()
  "Add double quotes before and after each line with a comma at the end."
  (interactive)
  (goto-char (point-min))
  (while (not (eobp))
    (beginning-of-line)
    (insert "\"")
    (end-of-line)
    (insert "\",")
    (forward-line 1)))

(defun drr-add-single-quotes-and-commas ()
  "Add single quotes before and after each line with a comma at the end."
  (interactive)
  (goto-char (point-min))
  (while (not (eobp))
    (beginning-of-line)
    (insert "\'")
    (end-of-line)
    (insert "\',")
    (forward-line 1)))
