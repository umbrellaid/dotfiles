(setq debug-on-error t)
(setq-default fill-column 80)
(require-package 'spacemacs-theme)
(require-package 'fontaine)
(blink-cursor-mode 0)
(setq mu4e-html2text-command 'mu4e-shr2text)
(setq mu4e-html2text-browser 'browse-url-generic)
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-refile-folder "/gmail/[Gmail]/All Mail")
(setq mu4e-sent-messages-behavior 'delete)
(setq mu4e-maildir-shortcuts
      '((:maildir "/gmail/[Gmail]/All Mail"   :key ?a)
        (:maildir "/local_only_emails"   :key ?l)))
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

(add-to-list 'load-path "/home/david/Manual_Programming_Builds/notmuch/emacs")
(require 'notmuch)
(autoload 'notmuch "notmuch" "notmuch mail" t)
(setq notmuch-database-path "/media/david/99d25f34-a775-4723-b0b7-f7afd58db67b/myINTERNAL/reorganized_emails/")
(setq notmuch-search-result-limit 1000)
(setq fontaine-latest-state-file
      (locate-user-emacs-file "fontaine-latest-state.eld"))

;; Iosevka Comfy is my highly customised build of Iosevka with
;; monospaced and duospaced (quasi-proportional) variants as well as
;; support or no support for ligatures:
;; <https://github.com/protesilaos/iosevka-comfy>.
(setq fontaine-presets
      '((small
         :default-family "Iosevka Comfy Motion Fixed"
         :default-height 80
         :variable-pitch-family "Iosevka Comfy Duo")
        (regular) ; like this it uses all the fallback values and is named `regular'
        (medium
         :default-weight semilight
         :default-height 115
         :bold-weight extrabold)
        (large
         :inherit medium
         :default-height 150)
        (presentation
         :default-height 180)
        (t
         ;; I keep all properties for didactic purposes, but most can be
         ;; omitted.  See the fontaine manual for the technicalities:
         ;; <https://protesilaos.com/emacs/fontaine>.
         :default-family "Iosevka Comfy Fixed"
         :default-weight regular
         :default-height 100

         :fixed-pitch-family nil ; falls back to :default-family
         :fixed-pitch-weight nil ; falls back to :default-weight
         :fixed-pitch-height 1.0

         :fixed-pitch-serif-family nil ; falls back to :default-family
         :fixed-pitch-serif-weight nil ; falls back to :default-weight
         :fixed-pitch-serif-height 1.0

         :variable-pitch-family "Iosevka Comfy Motion Duo"
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

(mapc #'disable-theme custom-enabled-themes)
;; (load-theme 'spacemacs-light :noconfirm)
(load-theme 'spacemacs-dark :noconfirm)
