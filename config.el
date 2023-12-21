;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If macs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; my system config
(setq system-time-locale "C")
(setq fancy-splash-image (concat doom-user-dir "splash.svg"))
(setq +doom-dashboard-functions
      (list #'doom-dashboard-widget-banner
            #'doom-dashboard-widget-shortmenu
            #'doom-dashboard-widget-loaded))
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org-agenda
  (setq org-log-into-drawer t)
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "LOOP(r)"  ; A recurring task
           "STRT(s@)"  ; A task that is in progress
           "WAIT(w@)"  ; Something external is holding up this task
           "NEXT(n@)"
           "HOLD(h@)"  ; This task is paused/on hold because of me
           "IDEA(i@)"  ; An unconfirmed and unapproved task or notion
           "|"
           "DONE(d@)"  ; Task successfully completed
           "KILL(k@)") ; Task was cancelled, aborted, or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S@)"   ; Task is in progress
           "[?](W@)"   ; Task is being held up or paused
           "|"
           "[X](D@)")  ; Task was completed
          (sequence
           "|"
           "OKAY(O)"
           "YES(Y)"
           "NO(N)"))
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("STRT" . +org-todo-active)
          ("NEXT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("NO"   . +org-todo-cancel)
          ("KILL" . +org-todo-cancel)))
  ;; with fast selection keys
  (setq org-tag-alist (quote ((:startgroup)
                              ("@HOME" . ?h)
                              ("@WORK" . ?w)
                              ("@RESEARCH" . ?r)
                              (:endgroup)
			      ("DL" . ?P)
                              ("HAND" . ?H)
                              ("CODE" . ?c))))
  (setq org-agenda-custom-commands
        '(("w" tags-todo "+@WORK")
	  ("h" tags-todo "+@HOME")
          ("r" tags-todo "+@RESEARCH")
	  )))

(after! org-capture
  (set 'org-capture-templates
       (append org-capture-templates
               '(("m" "my todo")
                 ("mw" "my work todo" entry
                  (file+headline +org-capture-todo-file "Work")
                  "* TODO %?\n%a\n%i" :prepend t)
                 ("mn" "my note todo" entry
                  (file+headline +org-capture-todo-file "Note")
                  "* TODO %?\n%a\n%i" :prepend t)
                 ))))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
