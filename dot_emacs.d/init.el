(setq debug-on-error t)
(setq my-environment "HOME")
(if (string-equal my-environment "WORK")
    (progn
      (message "if part of WORK code running...")
      (setenv "HOME" "C:\\Users\\recordr\\AppData\\Roaming\\")
      (setenv "PATH" (concat (getenv "PATH") ":C:/ProgramData/chocoportable/bin/"))
      (setq exec-path (append exec-path '("C:/ProgramData/chocoportable/bin/")))
      (global-unset-key (kbd "<scroll>"))
      (global-set-key (kbd "<scroll>") 'ignore)
      (setq w32-scroll-lock-modifier nil)
      (progn
        (with-eval-after-load "ispell"
          (add-to-list 'ispell-hunspell-dict-paths-alist '("en_US" "C:/Hunspell/en_US.aff")))
        (setq ispell-program-name "hunspell")
        (setenv "LANG" "en_US")
        (setq ispell-dictionary "en_US")
        )
      (setq denote-directory (expand-file-name "~/org-notes/"))
      (setq denote-known-keywords '("passwords" "code" "snippets" "links" "software" "settings"))
      (setq denote-dired-directories
            (list denote-directory
                  (expand-file-name "~/org-notes/")))
      )
  (progn
    (message "Else part of WORK code running...")
    ))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))
(if (string-equal my-environment "WORK")
    (progn
      (message "if part of WORK code running...")
      (load "C:/Users/recordr/AppData/Roaming/crafted-emacs-master/modules/crafted-init-config"))
  (progn
    (message "Else part of WORK code running...")
    ))
(if (string-equal my-environment "HOME")
    (progn
      (message "if part of HOME code running...")
      (load "~/crafted-emacs-master/modules/crafted-init-config")
      (add-to-list 'package-selected-packages 'greader)
      (add-to-list 'package-selected-packages 'elfeed)
      (add-to-list 'package-selected-packages 'notmuch)
      )
  (progn
    (message "Else part of HOME code running...")
    )
  )
(add-to-list 'package-selected-packages 'toc-org)
(add-to-list 'package-selected-packages 'modus-themes)
(add-to-list 'package-selected-packages 'denote)
(add-to-list 'package-selected-packages 'spacious-padding)
(add-to-list 'package-selected-packages 'fontaine)
(add-to-list 'package-selected-packages 'evil-escape)
(add-to-list 'package-selected-packages 'evil-surround)
(add-to-list 'package-selected-packages 'evil-numbers)
(add-to-list 'package-selected-packages 'evil-visualstar)
(add-to-list 'package-selected-packages 'olivetti)
(add-to-list 'package-selected-packages 'casual-info)
(add-to-list 'package-selected-packages 'casual-dired)
(add-to-list 'package-selected-packages 'casual-re-builder)
(add-to-list 'package-selected-packages 'yasnippet)
(add-to-list 'package-selected-packages 'avy)
                                        ; * Crafted Emacs Completion Module::
;; Add package definitions for completion packages
;; to `package-selected-packages'.
(require 'crafted-completion-packages)
                                        ; * Crafted Emacs Defaults Module::
                                        ; No package.
                                        ; * Crafted Emacs Evil Module::
(require 'crafted-evil-packages)
                                        ; * Crafted Emacs IDE Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Lisp Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Org Module::
(require 'crafted-org-packages)
                                        ; * Crafted Emacs OSX Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Screencast Module::
(require 'crafted-screencast-packages)
                                        ; * Crafted Emacs Speedbar Module::
                                        ; No package.
                                        ; * Crafted Emacs Startup Module::
                                        ; No package.
                                        ; * Crafted Emacs UI Module::
(require 'crafted-ui-packages)
                                        ; * Crafted Emacs Updates Module::
                                        ; No package.
                                        ; * Crafted Emacs Workspaces Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Writing Module::
                                        ; I decided not to use this section.
(package-install-selected-packages :noconfirm)
                                        ; * Crafted Emacs Completion Module::
;; Load configuration for the completion module
(require 'crafted-completion-config)
                                        ; * Crafted Emacs Defaults Module::
(require 'crafted-defaults-config)
                                        ; * Crafted Emacs Evil Module::
(require 'crafted-evil-config)
                                        ; * Crafted Emacs IDE Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Lisp Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Org Module::
(require 'crafted-org-config)
                                        ; * Crafted Emacs OSX Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Screencast Module::
(require 'crafted-screencast-config)
                                        ; * Crafted Emacs Speedbar Module::
(require 'crafted-speedbar-config)
                                        ; * Crafted Emacs Startup Module::
(require 'crafted-startup-config)
                                        ; * Crafted Emacs UI Module::
(require 'crafted-ui-config)
                                        ; * Crafted Emacs Updates Module::
                                        ; I decided to handle updating crafted-emacs manually.
                                        ; * Crafted Emacs Workspaces Module::
                                        ; I decided not to use this section.
                                        ; * Crafted Emacs Writing Module::
                                        ; I decided not to use this section.
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/"
        ))
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
(if (string-equal my-environment "HOME")
    (progn
      (message "if part of HOME code running...")
      (setq denote-directory (expand-file-name "~/org-notes/"))
      (setq denote-known-keywords '("passwords" "code" "snippets" "links" "software" "settings"))
      (setq denote-dired-directories
            (list denote-directory
                  (expand-file-name "~/org-notes/")))
      )
  (progn
    (message "Else part of HOME code running...")
    )
  )
(setq sentence-end-double-space nil)
;; In an emacs lisp scratch buffer you can run this code to double
;; check value of variable:
;; (message "Current fill-column value: %d" fill-column)
;; M-x display-fill-column-indicator-mode
;; to show vertical line at the fill-column
;; highlight text and press ALT-q to fill text to that width
(setq-default fill-column 80)
(blink-cursor-mode 0)
(set-default-coding-systems 'utf-8)
(spacious-padding-mode 1)
(setq fontaine-latest-state-file
      (locate-user-emacs-file "fontaine-latest-state.eld"))
(setq fontaine-presets
      '((small
         :default-family "CaskaydiaCove NF"
         :default-height 120
         :variable-pitch-family "Liberation Sans")
        (regular)
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
         :default-family "CaskaydiaCove NF"
         :default-weight regular
         :default-height 120
         :fixed-pitch-family nil
         :fixed-pitch-weight nil
         :fixed-pitch-height 1.0
         :fixed-pitch-serif-family nil
         :fixed-pitch-serif-weight nil
         :fixed-pitch-serif-height 1.0
         :variable-pitch-family "Liberation Sans"
         :variable-pitch-weight nil
         :variable-pitch-height 1.0
         :mode-line-active-family nil
         :mode-line-active-weight nil
         :mode-line-active-height 0.9
         :mode-line-inactive-family nil
         :mode-line-inactive-weight nil
         :mode-line-inactive-height 0.9
         :header-line-family nil
         :header-line-weight nil
         :header-line-height 0.9
         :line-number-family nil
         :line-number-weight nil
         :line-number-height 0.9
         :tab-bar-family nil
         :tab-bar-weight nil
         :tab-bar-height 1.0
         :tab-line-family nil
         :tab-line-weight nil
         :tab-line-height 1.0
         :bold-family nil
         :bold-weight bold
         :italic-family nil
         :italic-slant italic
         :line-spacing nil)))
(fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))
(fontaine-mode 1)
(setq denote-save-buffers nil)
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil)
(setq denote-prompts '(title keywords))
(setq denote-excluded-directories-regexp nil)
(setq denote-excluded-keywords-regexp nil)
(setq denote-rename-confirmations '(rewrite-front-matter modify-file-name))
(setq denote-date-prompt-use-org-read-date t)
(setq denote-date-format nil)
(setq denote-backlinks-show-context t)
(add-hook 'text-mode-hook #'denote-fontify-links-mode-maybe)
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
(denote-rename-buffer-mode 1)
(let ((map global-map))
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n c") #'denote-region) ; "contents" mnemonic
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n z") #'denote-signature) ; "zettelkasten" mnemonic
  (define-key map (kbd "C-c n s") #'denote-subdirectory)
  (define-key map (kbd "C-c n t") #'denote-template)
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-add-links)
  (define-key map (kbd "C-c n b") #'denote-backlinks)
  (define-key map (kbd "C-c n f f") #'denote-find-link)
  (define-key map (kbd "C-c n f b") #'denote-find-backlink)
  (define-key map (kbd "C-c n r") #'denote-rename-file)
  (define-key map (kbd "C-c n R") #'denote-rename-file-using-front-matter))
(let ((map dired-mode-map))
  (define-key map (kbd "C-c C-d C-i") #'denote-link-dired-marked-notes)
  (define-key map (kbd "C-c C-d C-r") #'denote-dired-rename-files)
  (define-key map (kbd "C-c C-d C-k") #'denote-dired-rename-marked-files-with-keywords)
  (define-key map (kbd "C-c C-d C-R") #'denote-dired-rename-marked-files-using-front-matter))
(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))
(add-hook 'context-menu-functions #'denote-context-menu)
(defvar ce-example-use-evil-escape t
  "Load `evil-escape' package with example.
`evil-escape': Bind Escape to an alternative key combination (e.g. `jj').")
(when ce-example-use-evil-escape
  (add-to-list 'package-selected-packages 'evil-escape))
(when ce-example-use-evil-escape
  (customize-set-variable 'evil-escape-key-sequence (kbd "jk"))
  (customize-set-variable 'evil-escape-delay 0.2)
  (defun ce-evil-example/not-insert-state-p ()
    "Inverse of `evil-insert-state-p`"
    (not (evil-insert-state-p)))
  (customize-set-variable 'evil-escape-inhibit-functions
                          (list #'ce-evil-example/not-insert-state-p))
  (evil-escape-mode))
(define-key dired-mode-map (kbd "E")
            (defun open-window-manager ()
              "Open default system windows manager in current directory"
              (interactive)
              (save-window-excursion
                (if (equal window-system 'w32)
                    (async-shell-command "explorer .")
                  (if (equal window-system 'x)
                      (async-shell-command "caja ."))))))
(defun drr-insert-date-stamp-prefix ()
  "Inserts the current date in mm-dd-yyyy format, prefixed with 'Date: '."
  (interactive)
  (insert (format-time-string "Date: %m-%d-%Y")))
(defun drr-insert-date-stamp ()
  "Inserts the current date in mm-dd-yyyy format"
  (interactive)
  (insert (format-time-string "%m-%d-%Y")))
(defun drr-my-reindent-file ()
  "Reindent the entire file and return to the original cursor position."
  (interactive)
  (let ((original-line (line-number-at-pos))
        (original-column (current-column)))
    (goto-char (point-min))
    (mark-whole-buffer)
    (indent-region (point-min) (point-max))
    (goto-line original-line)
    (move-to-column original-column nil)
    ))
(defun drr-condense-blank-lines ()
  "Condense multiple blank lines into a single blank line in the entire buffer."
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\n\n+" nil t)
    (replace-match "\n\n")))
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
(setq org-directory "~/org-notes")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files (list (expand-file-name "todo.org" org-directory)
                             (expand-file-name "work.org" org-directory)
                             (expand-file-name "personal.org" org-directory)))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (expand-file-name "todo.org" org-directory) "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("w" "Work" entry (file+headline (expand-file-name "work.org" org-directory) "Work")
         "* TODO %?\n  %i\n  %a")
        ("p" "Personal" entry (file+headline (expand-file-name "personal.org" org-directory) "Personal")
         "* TODO %?\n  %i\n  %a")))
(setq mu4e-html2text-command 'mu4e-shr2text)
(setq mu4e-html2text-browser 'browse-url-generic)
(setq browse-url-generic-program "firefox")
(defun drr-copy-all-text ()
  "Selects all text in the buffer and copies it to the kill ring."
  (interactive)
  (mark-whole-buffer)
  (kill-ring-save (point-min) (point-max)))
(global-set-key (kbd "C-c C-c") 'drr-copy-all-text)
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
(mapc #'disable-theme custom-enabled-themes)
(load-theme 'modus-operandi-tinted :noconfirm)
(add-hook 'org-mode-hook 'toc-org-mode)
(if (string-equal my-environment "HOME")
    (progn
      (message "if part of HOME code running...")
      (setq greader-espeak-rate 300)
      (setq elfeed-feeds
            '(
              )
            )
      (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
      (require 'mu4e)
      (setq mail-user-agent 'mu4e-user-agent)
      (setq mu4e-drafts-folder "/gmail/[Gmail]/Drafts")
      (setq mu4e-sent-folder   "/gmail/[Gmail]/Sent Mail")
      (setq mu4e-trash-folder  "/gmail/[Gmail]/Trash")
      (setq mu4e-refile-folder "/gmail/[Gmail]/All Mail")
      (setq mu4e-sent-messages-behavior 'delete)
      (setq mu4e-maildir-shortcuts
            '( (:maildir "/gmail/INBOX"              :key ?i)
               (:maildir "/gmail/[Gmail]/Sent Mail"  :key ?s)
               (:maildir "/gmail/[Gmail]/Trash"      :key ?t)
               (:maildir "/gmail/[Gmail]/All Mail"   :key ?a)))

      (add-to-list 'mu4e-bookmarks
                   '(:query "maildir:/inbox" :name "Inbox" :key ?i :favorite t))
      (setq
       user-mail-address "daverecor@gmail.com"
       user-full-name  "David Recor"
       message-signature
       (concat
        "David Recor"))
      ;; make sure the gnutls command line utils are installed
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
      (setq message-kill-buffer-on-exit t)
      (add-to-list 'mu4e-headers-actions
                   '("View in browser" . mu4e-action-view-in-browser) t)
      (setq mu4e-change-filenames-when-moving t)
      )
  (progn
    (message "Else part of HOME code running...")
    ))
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
(global-evil-visualstar-mode 1)
(global-evil-surround-mode 1)
