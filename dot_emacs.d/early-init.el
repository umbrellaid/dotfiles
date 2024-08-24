(setq my-environment "HOME")
(if (string-equal my-environment "WORK")
    (progn
      (message "if part of WORK code running...")
      (load "C:/Users/recordr/AppData/Roaming/crafted-emacs-master/modules/crafted-early-init-config")
      )
  (progn
    (message "Else part of WORK code running...")
    ))
(if (string-equal my-environment "HOME")
    (progn
      (message "if part of HOME code running...")
      (load "~/crafted-emacs-master/modules/crafted-early-init-config")
      )
  (progn
    (message "Else part of HOME code running...")
    ))

