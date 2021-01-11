(add-to-list 'load-path "~/.emacs.d/lisp")

;; ---------------------------------------------------------------------------

;(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(package-initialize)

(setq-default
 fill-column 72
 c-basic-offset 4
 indent-tabs-mode nil
 show-trailing-whitespace t
 sentence-end-double-space nil
 require-final-newline 'visit-save
 save-place t)

(setq
 inhibit-startup-screen t
 initial-major-mode 'text-mode
 initial-scratch-message (format-time-string "# Started at %F %T\n\n")
 echo-keystrokes (/ 1.0 6)
 use-dialog-box nil
 scroll-preserve-screen-position t
 mouse-yank-at-point t
 custom-file "~/.emacs.d/local-state/customized-variables.el"
 savehist-file "~/.emacs.d/local-state/minibuffer-history.el"
 recentf-save-file "~/.emacs.d/local-state/recent-files.el"
 save-place-file "~/.emacs.d/local-state/saved-places.el"
 abbrev-file-name "~/.emacs.d/local-state/abbrevs.el"
 custom-theme-directory "~/.emacs.d/themes"
 make-backup-files nil
 backup-by-copying-when-linked t
 backup-directory-alist '((".*" . "~/.emacs.d/local-state/backups"))
 auto-save-file-name-transforms `((".*" "~/.emacs.d/local-state/auto-saves" t))
 safe-local-variable-values '((encoding . utf-8))
 dired-listing-switches "-alhoF"
 ispell-program-name "aspell"
 ispell-list-command "list"
 isearch-allow-scroll t
 vc-follow-symlinks t)

;; ---------------------------------------------------------------------------

(global-set-key (kbd "C-x c") 'server-edit)

(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)

;; ; i wonder if i can train myself to do this
;; (global-set-key (kbd "C-v") 'yank)
;; (global-set-key (kbd "M-v") 'yank-pop)
;; (global-unset-key (kbd "C-y"))
;; (global-unset-key (kbd "M-y"))

(global-set-key (kbd "<C-up>") 'scroll-down-line)
(global-set-key (kbd "<C-down>") 'scroll-up-line)

;; Yes, this is absurd. Yes, universal-argument will still echo "C-u"
;; under the mode line. There's some code in execute-extended-command
;; that depends on prefix args being represented as that internally.

(global-set-key (kbd "M-`") 'universal-argument)

(defun backward-kill-line ()
  (interactive)
  (kill-line 0))
(global-set-key (kbd "C-u") 'backward-kill-line)

(global-set-key (kbd "C-j") 'join-line) ; i should reverse the arg/no-arg meanings

(global-set-key (kbd "C-x [") 'kmacro-start-macro)
(global-set-key (kbd "C-x ]") 'kmacro-end-macro)

(global-set-key (kbd "<down-mouse-3>")
  `(menu-item ,(purecopy "Menu Bar") ignore
    :filter (lambda (_)
              (if (zerop (or (frame-parameter nil 'menu-bar-lines) 0))
                  (mouse-menu-bar-map)
                (mouse-menu-major-mode-map)))))

(global-set-key (kbd "C-x M-f") 'find-file-at-point)
(global-set-key (kbd "C-x \\") 'align-regexp)

(defun kill-this-buffer ()
  (interactive)
  (kill-buffer nil))

(global-set-key (kbd "C-x C-b") 'buffer-menu-other-window)
(global-set-key (kbd "s-n") 'previous-buffer)
(global-set-key (kbd "s-p") 'next-buffer)
(global-set-key (kbd "s-k") 'kill-this-buffer)

;; (with-eval-after-load 'info
;;   (define-key Info-mode-map (kbd "M-n") 'next-buffer))

(define-key minibuffer-local-map (kbd "M-p") 'previous-complete-history-element)
(define-key minibuffer-local-map (kbd "M-n") 'next-complete-history-element)
(define-key minibuffer-local-map (kbd "C-p") 'previous-history-element)
(define-key minibuffer-local-map (kbd "C-n") 'next-history-element)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; ---------------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js-mode))
(add-to-list 'auto-mode-alist '("shrc\\'" . sh-mode))
(add-to-list 'auto-mode-alist '(".*/\\.shrc\\.?" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.step\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Cheffile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.tweets\\'" . tweet-text-mode))
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . text-mode))
(add-to-list 'auto-mode-alist '("README\\'" . text-mode))
(add-to-list 'auto-mode-alist '("LICENSE\\'" . text-mode))

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "M-n") nil)
  (define-key markdown-mode-map (kbd "M-p") nil))

(require 'dtrt-indent nil t)
(with-eval-after-load 'dtrt-indent
  (add-hook 'sh-mode-hook 'dtrt-indent-mode)
  (add-hook 'ruby-mode-hook 'dtrt-indent-mode)
  (add-hook 'rust-mode-hook 'dtrt-indent-mode)
  (add-hook 'perl-mode-hook 'dtrt-indent-mode)
  (add-hook 'js-mode-hook 'dtrt-indent-mode)
  (add-hook 'typescript-mode-hook 'dtrt-indent-mode)
  (add-hook 'css-mode-hook 'dtrt-indent-mode))

(setq ruby-align-chained-calls t
      ruby-align-to-stmt-keywords t
      ruby-deep-indent-paren nil
      ruby-deep-indent-paren-style nil)

(add-hook 'ruby-mode-hook 'robe-mode)
(advice-add #'inf-ruby-console-auto :around
            (lambda (orig-function &rest arguments)
              (if (file-exists-p "Gemfile")
                  (apply orig-function arguments)
                (inf-ruby))))

(setq js2-auto-indent-flag nil
      js2-mode-escape-quotes nil
      js2-cleanup-whitespace nil
      js2-enter-indents-newline nil
      js2-mirror-mode nil
      js2-mode-escape-quotes nil
      js2-mode-squeeze-spaces nil
      js2-rebind-eol-bol-keys nil)

(setq-default
 css-indent-offset 2
 coffee-tab-width 2
 haskell-indent-offset 2)

;; oh this is kind of broad given how many modes derive from text mode
;; what i want is fill column set to the longest line
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; ---------------------------------------------------------------------------

(setq frame-title-format
      `(,(invocation-name) "@" ,(system-name) ": %["
        (buffer-file-name "%f" (dired-directory dired-directory "%b"))
        "%] %*"))

;; i couldn't get either term/xterm.el or the xterm-title.el on
;; emacswiki to work, so just do it ourselves :-( at least it's simpler?

(defun send-xterm-osc (cs text)
  (send-string-to-terminal (concat "\033]" cs ";" text "\007")))

(defun xterm-title-update ()
  (let ((icon-name (buffer-name))
        (window-title (format-mode-line frame-title-format)))
    (send-xterm-osc "1" icon-name)
    (send-xterm-osc "2" window-title)))

;; this trades being always 100% up to date for efficiency
;; TODO: find a hook that will run on entering/exiting recursive edit

(add-hook 'buffer-list-update-hook 'xterm-title-update)
(add-hook 'first-change-hook 'xterm-title-update)

;; ---------------------------------------------------------------------------

(defmacro when-bound (form)
  `(when (fboundp ',(car form))
     ,form))

(savehist-mode 1)
(recentf-mode t)
(save-place-mode 1)
(menu-bar-mode 0)
(when-bound (tool-bar-mode 0))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(blink-cursor-mode 0)
(column-number-mode)
(show-paren-mode)
(add-hook 'dired-mode-hook 'toggle-truncate-lines)

(defun save-mark-active (&rest r)
  "Restore the mark's active or inactive state after calling a function.
  Useful if you want to enable transient-mark-mode but suppress automatic
  activation for a particular command."
  (let ((orig-mark-active mark-active))
    (apply r)
    (if orig-mark-active
        (activate-mark nil)
      (deactivate-mark nil))))
(advice-add 'exchange-point-and-mark :around #'save-mark-active)

(load "make-mark-visible")

;; ---------------------------------------------------------------------------

(require 'which-key nil t)
(with-eval-after-load 'which-key
  (which-key-mode))

(load "rotate-text" t)

(load custom-file t)

(add-to-list 'custom-theme-load-path custom-theme-directory)

(load "local-init" t)
