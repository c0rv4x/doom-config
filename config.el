;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Update font settings
;; (setq doom-font (font-spec :family "Droid Sans Mono" :size 20))
(setq doom-font (font-spec :family "Droid Sans Mono" :size 20))


;; treemacs hide py cache files
(with-eval-after-load 'treemacs
  (defun treemacs-ignore-example (filename absolute-path)
    (or (string-equal filename ".mypy_cache")
        (string-equal filename ".pytest_cache")
        (string-equal filename "__pycache__")))

  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-example))


;; Treemacs switcher
(defun +private/treemacs-back-and-forth ()
  (interactive)
  (if (treemacs-is-treemacs-window-selected?)
      (aw-flip-window)
    (treemacs-select-window)))

(map! :after treemacs
      :leader
      :n "-" #'+private/treemacs-back-and-forth)

(use-package! lsp
  :init
  (setq lsp-pyls-plugins-yapf-enabled t)
  (setq lsp-pyls-plugins-autopep8-enabled nil)
)

(after! flycheck
  :init
  (add-to-list 'flycheck-disabled-checkers 'python-pylint)
)

(setq-hook! 'python-mode-hook +format-with :none)

;; (use-package! yapfify
;;   :hook
;;   (python-mode . yapf-mode)
;;   (before-save . (lambda ()
;;                    (when (eq major-mode 'python-mode)
;;                      (yapfify-buffer)))))

(defun format-python-buffer ()
  (message "Format python buffer called")
  (when (eq major-mode 'python-mode)
    (message "Formatting...")
    (lsp-format-buffer)))

(add-hook 'before-save-hook #'format-python-buffer)


(setq company-idle-delay 0)


;; evil-mc
(define-key evil-normal-state-map (kbd "M-d") #'evil-mc-make-and-goto-next-match)
(define-key evil-visual-state-map (kbd "M-d") #'evil-mc-make-and-goto-next-match)
(define-key evil-normal-state-map (kbd "M-D") #'evil-mc-make-and-goto-prev-match)
(define-key evil-visual-state-map (kbd "M-D") #'evil-mc-make-and-goto-prev-match)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
