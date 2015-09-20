;;;
;;; Mike's .emacs file
;;;

;; Load common lisp extensions
(require 'cl)

;;------------------------------------------------------------------------------
;; Fix the PATH variable

(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
                       (getenv "HOME") "/.rbenv/bin:"
                       (getenv "PATH") ))
(setq exec-path
      (cons (concat (getenv "HOME") "/.rbenv/shims")
            (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path) ))

;;------------------------------------------------------------------------------
;; OS settings

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super) )

;;------------------------------------------------------------------------------
;; Packages

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/") ))

;; Load packages now, not after init
(require 'package)
(setq package-enable-at-startup nil) ;; To avoid initializing twice
(package-initialize)
(package-refresh-contents)

(defvar my-packages
  '(ag
    auto-complete
    auto-highlight-symbol
    autopair
    avy
    buffer-move
    clojure-mode
    coffee-mode
    discover
    drag-stuff
    emr
    enh-ruby-mode
    expand-region
    flx-ido
    ido-ubiquitous
    js2-mode
    magit
    matlab-mode
    markdown-mode
    mmm-mode
    molokai-theme
    monokai-theme
    multi-term
    neotree
    projectile
    projectile-rails
    railscasts-theme
    rainbow-mode
    rbenv
    rubocop
    ruby-end
    ruby-hash-syntax
    ruby-refactor
    rspec-mode
    sass-mode
    scss-mode
    slim-mode
    smex
    solarized-theme
    sr-speedbar
    visual-regexp
    workgroups
    xkcd
    yaml-mode
    zenburn-theme
    zygospore ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p) ))

;;------------------------------------------------------------------------------
;; Included lisp and required libraries

;; Load lisp files
(defvar emacs-root "~/.emacs.d/")
;; cl-labels is like let for functions
(cl-labels
    ((add-path (p) (add-to-list 'load-path (concat emacs-root p))))
  (add-path "lisp")
  (add-path "themes") )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;;------------------------------------------------------------------------------
;; Global config

(setq inhibit-startup-message t)

;; We don't need no stinkin' GUI
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq make-backup-files nil)
(setq ring-bell-function 'ignore)

;; Disable some annoying prompts
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)

(setq-default cursor-type 'bar)
(setq-default blink-cursor-blinks 0)

;; Scrolling
(setq scroll-preserve-screen-position t)
(setq mouse-wheel-progressive-speed nil)

;; Replaces M-x to run commands
(smex-initialize)
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)

;;------------------------------------------------------------------------------
;; Global modes

;; Show line/column number in minibuffer
(setq line-number-mode t)
(setq column-number-mode t)

(show-paren-mode 1)

(global-hl-line-mode 1) ;; Highlight current line
(auto-highlight-symbol-mode) ;; Highlight current symbol

(drag-stuff-global-mode)

(setq comment-style 'indent)

(global-rbenv-mode)

(autopair-global-mode)

(global-discover-mode 1)

;; Line numbers
(global-set-key (kbd "C-<f5>") 'linum-mode)

;;------------------------------------------------------------------------------
;; Saving

(global-set-key [f9] 'save-buffer)
(global-set-key [f10] 'save-buffer)
(desktop-save-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)

;;------------------------------------------------------------------------------
;; Font size / text size

(let ((miken-font-size
       (cond
        ((<= (display-pixel-height) 800) "14")
        ((<= (display-pixel-height) 1200) "16")
        ((<= (display-pixel-height) 1440) "18")
        (t "18") )))
  (set-face-attribute 'default nil :font (concat "Inconsolata-" miken-font-size)) )

;;------------------------------------------------------------------------------
;; Color themes

(load-theme 'railscasts t nil)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (if (string-match ".*theme.*" (buffer-name))
                (rainbow-mode) )))

;; TODO: figure out why this happens
(set-cursor-color "#ffffff")

;; (defun override-theme (theme)
;;   "Clear out the active themes and load a theme freshly"
;;   (interactive "sOverride with custom theme: ")
;;   (while custom-enabled-themes
;;     (disable-theme (car custom-enabled-themes)))
;;   (load-theme theme t nil))

;;------------------------------------------------------------------------------
;; Frame management

(global-set-key (kbd "M-`") 'other-frame)

;;------------------------------------------------------------------------------
;; Window management

(require 'workgroups)
(workgroups-mode 1)
(if (file-exists-p "~/.emacs.d/workgroups")
    (wg-load "~/.emacs.d/workgroups"))
;; (setq wg-query-for-save-on-emacs-exit nil)

(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

;; Also bound to C-x +
(global-set-key (kbd "C-x =") 'balance-windows)

;; Move cursor to other window
(global-set-key (kbd "M-s-h") 'windmove-left)
(global-set-key (kbd "M-s-j") 'windmove-down)
(global-set-key (kbd "M-s-k") 'windmove-up)
(global-set-key (kbd "M-s-l") 'windmove-right)

;; Move buffer to other window
(when (require 'buffer-move nil 'noerror)
  (global-set-key (kbd "C-s-h") 'buf-move-left)
  (global-set-key (kbd "C-s-j") 'buf-move-down)
  (global-set-key (kbd "C-s-k") 'buf-move-up)
  (global-set-key (kbd "C-s-l") 'buf-move-right) )

;; Window resizing
(global-set-key (kbd "M-s-<up>")
                (lambda () (interactive) (enlarge-window 2)))
(global-set-key (kbd "M-s-<down>")
                (lambda () (interactive) (enlarge-window -2)))
(global-set-key (kbd "M-s-<left>")
                (lambda () (interactive) (enlarge-window -2 t)))
(global-set-key (kbd "M-s-<right>")
                (lambda () (interactive) (enlarge-window 2 t)))

;;------------------------------------------------------------------------------
;; Buffer management

(global-set-key "\C-ck" 'kill-buffer-and-window)
(global-set-key "\C-c\C-k" 'kill-buffer-and-window)

(global-set-key "\C-cb" 'switch-to-buffer-other-window)
(global-set-key "\C-c\C-b" 'switch-to-buffer-other-window)

;; Already bound to C-x b
(global-set-key "\C-x\C-b" 'switch-to-buffer)

;; Previously bound to C-x C-b
(global-set-key "\C-x\C-l" 'list-buffers)

(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward)

;;------------------------------------------------------------------------------
;; Region management

(global-set-key "\C-ci" 'indent-region)

(require 'expand-region)
(global-set-key (kbd "s-<up>") 'er/expand-region)
(global-set-key (kbd "s-<down>") 'er/contract-region)

;; Delete region when you start typing
(pending-delete-mode t)

;;------------------------------------------------------------------------------
;; Paragraph management

(setq-default fill-column 90)

(defun endless/forward-paragraph (&optional n)
  "Advance just past next blank line."
  (interactive "p")
  (let ((m (use-region-p))
        (para-commands
         '(endless/forward-paragraph endless/backward-paragraph)))
    ;; Only push mark if it's not active and we're not repeating.
    (or m
        (not (member this-command para-commands))
        (member last-command para-commands)
        (push-mark))
    ;; The actual movement.
    (dotimes (_ (abs n))
      (if (> n 0)
          (skip-chars-forward "\n[:blank:]")
        (skip-chars-backward "\n[:blank:]"))
      (if (search-forward-regexp
           "\n[[:blank:]]*\n[[:blank:]]*" nil t (cl-signum n))
          (goto-char (match-end 0))
        (goto-char (if (> n 0) (point-max) (point-min)))))
    ;; If mark wasn't active, I like to indent the line too.
    (unless m
      (indent-according-to-mode)
      ;; This looks redundant, but it's surprisingly necessary.
      (back-to-indentation))))

(defun endless/backward-paragraph (&optional n)
  "Go back up to previous blank line."
  (interactive "p")
  (endless/forward-paragraph (- n)))

(global-set-key "\M-a" 'endless/backward-paragraph)
(global-set-key "\M-e" 'endless/forward-paragraph)

;;------------------------------------------------------------------------------
;; Projectile

;; Projectile because fuzzy file search
(projectile-global-mode)

(recentf-mode)

(global-set-key (kbd "M-s-f") 'projectile-find-file)
(global-set-key (kbd "M-s-v") 'projectile-vc)
(global-set-key (kbd "M-s-s") 'projectile-ag)

(setq projectile-mode-line " Pj")

;;------------------------------------------------------------------------------
;; Autocomplete/auto-complete

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)
(global-set-key "\M-/" 'auto-complete)
(global-set-key (kbd "C-M-/") 'ac-fuzzy-complete)
(setq-default completion-ignore-case 1)

;;------------------------------------------------------------------------------
;; Magit/git

(require 'magit)

(setq magit-last-seen-setup-instructions "1.4.0")
(setq magit-push-always-verify nil)

;; Don't prompt when first line of commit is over 50 chars.
(setq git-commit-finish-query-functions '())
;; Don't set new branch to track parent branch's remote
(setq magit-branch-arguments (remove "--track" magit-branch-arguments))

(setq magit-commit-arguments '("--verbose"))

(require 'vc-git)
(defun vc-git-annotate-command (file buffer &optional revision)
  "Execute \"git annotate\" on FILE, inserting the contents in BUFFER."
  (vc-git-command buffer 0 file "blame" "--abbrev=5") )
                  ;; " | sed 's/[0-9]*:[0-9]*:[0-9]*//g' | sed 's/-[0-9]\\{3,\\}//g' | tr -s ' '") )

;;------------------------------------------------------------------------------
;; Fuzzy file find

(ido-mode 1)
(ido-ubiquitous-mode)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(add-hook 'minibuffer-inactive-mode-hook
          (lambda ()
            (global-set-key (kbd "C-.") 'ido-next-match)
            (global-set-key (kbd "C-,") 'ido-prev-match) ))

;; From: http://endlessparentheses.com/Ido-Bury-Buffer.html
(add-hook 'ido-setup-hook
          (defun endless/define-ido-bury-key ()
            (define-key ido-completion-map
              (kbd "C-b") 'endless/ido-bury-buffer-at-head)))

(defun endless/ido-bury-buffer-at-head ()
  "Bury the buffer at the head of `ido-matches'."
  (interactive)
  (let ((enable-recursive-minibuffers t)
        (buf (ido-name (car ido-matches)))
        (nextbuf (cadr ido-matches)))
    (when (get-buffer buf)
      ;; If next match names a buffer use the buffer object;
      ;; buffer name may be changed by packages such as
      ;; uniquify.
      (when (and nextbuf (get-buffer nextbuf))
        (setq nextbuf (get-buffer nextbuf)))
      (bury-buffer buf)
      (if (bufferp nextbuf)
          (setq nextbuf (buffer-name nextbuf)))
      (setq ido-default-item nextbuf
            ido-text-init ido-text
            ido-exit 'refresh)
      (exit-minibuffer))))

;;------------------------------------------------------------------------------
;; Searching / jumping / tags

(global-set-key (kbd "M-s-g") 'avy-goto-word-or-subword-1)

(global-set-key (kbd "s-s") 'isearch-forward-regexp)
(global-set-key (kbd "s-r") 'isearch-backward-regexp)

(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "M-,") 'pop-tag-mark)

;;------------------------------------------------------------------------------
;; Speedbar

;; sr-speedbar (safe require)
(when (require 'sr-speedbar nil 'noerror)
  (setq sr-speedbar-right-side nil)
  (setq sr-speedbar-skip-other-window-p t)
  (setq sr-speedbar-width 40)
  (speedbar-disable-update)
  (sr-speedbar-refresh-turn-off)
  (setq speedbar-show-unknown-files t)
  (setq speedbar-indentation-width 3)
  ;; I want stuff ignored a la carte
  (setq speedbar-directory-unshown-regexp "^\\(\\.\\.?\\|.idea\\)$")

  (defun miken-buffer-directory ()
    (if (buffer-file-name) (file-name-directory (buffer-file-name))
      (getenv "HOME") ))

  ;; Pulled these functions from projectile-speedbar.el
  (defun miken-find-project-root ()
    (if (projectile-project-p) (projectile-project-root)
      (miken-buffer-directory) ))

  (defun miken-speedbar-project-refresh (root-dir)
    "Refresh the context of speedbar based on project root"
    (if (and (not (equal root-dir sr-speedbar-last-refresh-dictionary))
             (not (sr-speedbar-window-p)))
        (setq sr-speedbar-last-refresh-dictionary root-dir) )
    (setq default-directory root-dir)
    (speedbar-refresh) )

  (defun miken-open-current-project-in-speedbar (root-dir)
    "Refresh speedbar to show current project in tree"
    (when (not (sr-speedbar-exist-p))
      (while (windmove-find-other-window 'left)
        (windmove-left) )
      (while (windmove-find-other-window 'up)
        (windmove-up) ))
    (sr-speedbar-toggle)
    (miken-speedbar-project-refresh root-dir) )

  ;; This opens the directory where the calling buffer lives
  (defun miken-speedbar-expand-line-list (&optional arg)
    (when arg
      (re-search-forward (concat " " (car arg) "$"))
      (speedbar-expand-line (car arg))
      (speedbar-next 1)
      (miken-speedbar-expand-line-list (cdr arg)) ))

  (defun miken-speedbar-open-current-buffer-in-tree ()
    (interactive)
    (let* ((root-dir (miken-find-project-root))
           (prev-buffer-directory (miken-buffer-directory))
           (relative-buffer-path (car (cdr (split-string prev-buffer-directory root-dir))))
           (parents (butlast (split-string relative-buffer-path "/")))
           (prev-buffer (buffer-name)) )
      (save-excursion
        (miken-open-current-project-in-speedbar root-dir)
        (select-window (get-buffer-window speedbar-buffer))
        (beginning-of-buffer)
        (miken-speedbar-expand-line-list parents)
        (unless (string= prev-buffer "*SPEEDBAR*")
          (switch-to-buffer  prev-buffer) ))))

  (defun miken-speedbar ()
    (interactive)
    (if (sr-speedbar-exist-p)
        (sr-speedbar-toggle)
      (miken-speedbar-open-current-buffer-in-tree) ))

  (global-set-key [f8] 'miken-speedbar)
)

(global-set-key [f7] 'neotree-toggle)

;;------------------------------------------------------------------------------
;; Refactoring

(define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
(add-hook 'prog-mode-hook 'emr-initialize)

(setq ruby-refactor-add-parens t)

;;------------------------------------------------------------------------------
;; Rails settings

(setq miken-rails-file-types
  '(;; Ruby
    ruby-mode-hook enh-ruby-mode-hook
    ;; JavaScript / CoffeeScript
    javascript-mode-hook js2-mode-hook coffee-mode-hook
    ;; Styles
    css-mode-hook sass-mode-hook scss-mode-hook
    ;; Markup
    html-mode-hook html-erb-mode-hook slim-mode-hook haml-mode-hook yaml-mode-hook))

;; Turn on projectile-rails-mode if we're in a rails project
(dolist (hook miken-rails-file-types)
  (add-hook hook
            (lambda ()
              (if (and
                   (projectile-project-p)
                   (file-exists-p (concat (projectile-project-root) "Gemfile")) )
                  (projectile-rails-mode) ))))

;; erb files
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)

(require 'mmm-erb)
(mmm-add-mode-ext-class 'html-erb-mode "\\.erb\\'" 'erb)
(mmm-add-mode-ext-class 'html-erb-mode "\\.jst" 'ejs)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . html-erb-mode))
(add-to-list 'auto-mode-alist '("\\.jst'"  . html-erb-mode))

;;------------------------------------------------------------------------------
;; rspec

(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/usr/local/bin/bash"))
    ad-do-it))

(ad-activate 'rspec-compile)

(setq compilation-scroll-output nil)

(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(global-set-key (kbd "M-s-t")
                (lambda () (interactive)
                  (split-window-below)
                  (windmove-down)
                  (rspec-toggle-spec-and-target) ))

(setq rspec-use-rake-when-possible nil)

;;------------------------------------------------------------------------------
;; Indentation for languages

;; Always spaces, always 2
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; elisp
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (define-key emacs-lisp-mode-map (kbd "RET") 'newline-and-indent) ))

;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
  (lambda ()
    (linum-mode)
    (define-key js2-mode-map (kbd "RET") 'newline-and-indent) ))

(add-hook 'js-mode-hook
  (lambda ()
    (linum-mode)
    (define-key js-mode-map (kbd "RET") 'newline-and-indent) ))

;; CoffeeScript
(add-hook 'coffee-mode-hook
  (lambda ()
    (linum-mode)
    (define-key coffee-mode-map (kbd "RET") 'newline-and-indent) ))

;; shell
(setq sh-indentation 2)
(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2) ))

;; erb
(add-hook 'html-erb-mode-hook
  (lambda ()
    (auto-complete-mode)
    (linum-mode) ))

;; CSS
(add-hook 'css-mode-hook
  (lambda ()
    (setq css-indent-offset 2)))

;; SASS
(add-hook 'sass-mode-hook
  (lambda ()
    (rainbow-mode)
    (setq css-indent-offset 2)))

;; SCSS
(add-hook 'scss-mode-hook
  (lambda ()
    (rainbow-mode)
    (setq css-indent-offset 2)))
(setq scss-compile-at-save nil)

;; Ruby
(setq ruby-end-insert-newline nil)
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . enh-ruby-mode))

(add-hook 'enh-ruby-mode-hook
  (lambda ()
    (ruby-end-mode)
    (linum-mode)
    (auto-complete-mode)
    (auto-highlight-symbol-mode)
    (define-key enh-ruby-mode-map (kbd "RET") 'newline-and-indent) ))

;; C
(add-hook 'c-mode-hook
  (lambda ()
    (setq tab-width 4)))

;; Java
(add-hook 'java-mode-hook
  (lambda ()
    (setq tab-width 4)))

;;------------------------------------------------------------------------------
;; Markdown

(add-hook 'markdown-mode-hook
  (lambda ()
    (miken-keys-minor-mode t) ))

;;------------------------------------------------------------------------------
;; ediff setup

(add-hook 'ediff-quit-hook 'winner-undo)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
;; DA-DA-DA DAAA, daa daa DAAT duh-DAAAAAA!
(if (fboundp 'winner-mode) (winner-mode 1))

;;------------------------------------------------------------------------------
;; Multi-term / shell config

(require 'multi-term)

(defun miken-switch-to-or-create-shell-buffer (index)
  "Switches to *terminal<INDEX>* if it exists, or creates a new terminal."
  (interactive)
  (let ((term-name (concat "*terminal<" index ">*")))
    (if (get-buffer term-name)
        (switch-to-buffer term-name)
      (switch-to-buffer (multi-term)) )))

(dolist (index '("1" "2" "3" "4" "5" "6" "7" "8" "9"))
  (global-set-key (kbd (concat "M-s-" index))
                  `(lambda () (interactive)
                     (miken-switch-to-or-create-shell-buffer ,index))))

(dolist (key-command
         '(("M-<backspace>" . term-send-backward-kill-word)
           ("M-d" . term-send-forward-kill-word)))
  (add-to-list 'term-bind-key-alist key-command))

;;------------------------------------------------------------------------------
;; Text manipulation

;; From the Yegge blog post "Saving Time"
(defun miken-fix-amazon-url ()
  "Minimizes the Amazon URL under the point.  You can paste an Amazon
  URL out of your browser, put the cursor in it somewhere, and invoke
  this method to convert it."
  (interactive)
  (and (search-backward "http://www.amazon.com" (point-at-bol) t)
       (search-forward-regexp
        ".+/\\([A-Z0-9]\\{10\\}\\)/[^[:space:]\"]+" (point-at-eol) t)
       (replace-match
        (concat "http://www.amazon.com/o/asin/"
                (match-string 1)
                (match-string 3) ))))

(defun miken-xml-format ()
  "Formats a region of XML to look nice"
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t) ))

(defun miken-json-format ()
  (interactive)
  (let ((begin (if mark-active (min (point) (mark)) (point-min)))
        (end (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region begin end
     "python -mjson.tool" (current-buffer) t)))

(defun miken-toggle-quotes ()
  "Toggle single quoted string to double or vice versa, and
  flip the internal quotes as well. Best to run on the first
  character of the string."
  (interactive)
  (save-excursion
    (move-beginning-of-line nil)
    (re-search-forward "[\"']")
    (backward-char 1)
    (let* ((start (point))
           (old-c (char-to-string (char-after start)))
           (new-c (if (string= old-c "'") "\"" "'")))
      (delete-char 1)
      (insert new-c)
      (re-search-forward old-c)
      (backward-char 1)
      (let ((end (point)))
        (delete-char 1)
        (insert new-c)
        (replace-string new-c old-c nil (1+ start) end)))))

(global-set-key (kbd "C-c t") 'miken-toggle-quotes)
(global-set-key (kbd "C-c C-t") 'miken-toggle-quotes)

;;------------------------------------------------------------------------------
;; Functions that should exist already

;; Never understood why Emacs doesn't have this function.
(defun miken-rename-buffer-and-file (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
    (let ((name (buffer-name))
          (filename (buffer-file-name)) )
      (if (not filename)
          (message "Buffer '%s' is not visiting a file!" name)
        (if (get-buffer new-name)
            (message "A buffer named '%s' already exists!" new-name)
          (progn (rename-file name new-name 1)
                 (rename-buffer new-name)
                 (set-visited-file-name new-name)
                 (set-buffer-modified-p nil) )))))

;; Never understood why Emacs doesn't have this function, either.
(defun miken-move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
    (let* ((name (buffer-name))
           (filename (buffer-file-name))
           (dir
            (if (string-match dir "\\(?:/\\|\\\\)$")
                (substring dir 0 -1) dir))
           (newname (concat dir "/" name)) )
      (if (not filename)
          (message "Buffer '%s' is not visiting a file!" name)
        (progn (copy-file filename newname 1)
               (delete-file filename)
               (set-visited-file-name newname)
               (set-buffer-modified-p nil) t))))

;; Word count
(defun miken-count-words-buffer ()
  "Counts the number of words in the buffer."
  (interactive)
  (let ((count 0))
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))
        (forward-word 1)
        (setq count (+ 1 count)) )
      (message "buffer contains %d words." count) )))

(defun miken-goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t                    (self-insert-command (or arg 1))) ))
;; TODO fix this to work if you're on either side of the paren
(global-set-key (kbd "C-c 9") 'miken-goto-match-paren)
(global-set-key (kbd "C-c C-9") 'miken-goto-match-paren)

;;------------------------------------------------------------------------------
;; Custom functions

;; This is the greatest and best function ever.
(defun miken-reload ()
  "Reloads the .emacs file"
  (interactive)
  (load-file "~/.emacs") )

(defun miken-copy-line-below (&optional n)
  "Duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((current-line (thing-at-point 'line)))
      ;; now insert as many time as requested
      (while (> n 0)
        (insert current-line)
        (decf n) )))
  (next-line))

(global-set-key (kbd "C-c d") 'miken-copy-line-below)
(global-set-key (kbd "C-c C-d") 'miken-copy-line-below)

;; Emulate vim's half-screen scrolling
(defun miken-window-half-height ()
  (max 1 (/ (+ 1 (window-height (selected-window))) 2)) )

(global-set-key (kbd "C-v")
                (lambda () (interactive)
                  (scroll-up (miken-window-half-height)) ))

(global-set-key (kbd "M-v")
                (lambda () (interactive)
                  (scroll-down (miken-window-half-height)) ))

(defun miken-vim-open-line-above ()
  "Insert a newline above the current line and indent point."
  (interactive)
  (unless (bolp)
    (beginning-of-line) )
  (newline)
  (forward-line -1)
  (indent-according-to-mode) )

(global-set-key (kbd "C-c o") 'miken-vim-open-line-above)
(global-set-key (kbd "C-c C-o") 'miken-vim-open-line-above)

(global-set-key [S-return]
                (lambda () (interactive)
                  (end-of-line)
                  (newline-and-indent) ))

;; In the pipe, five-by-five
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "M-n") (lambda () (interactive (next-line 5))))

(defun miken-current-buffer-filepath ()
  "Put the current file path on the clipboard"
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)) )
      (message filename) )))

(global-set-key (kbd "C-c `") 'miken-current-buffer-filepath)

(defun miken-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not blank, then comment current line.
   Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (not (region-active-p))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key (kbd "M-;") 'miken-comment-dwim-line)

(defun miken-comment-dwim-line-and-move-down (&optional arg)
  "Comment the current line and move to the next line"
  (interactive)
  (miken-comment-dwim-line arg)
  (next-line) )

(global-set-key (kbd "C-M-;") 'miken-comment-dwim-line-and-move-down)

(defun save-macro (name)
  "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of your .emacs"
  (interactive "SName of the macro :")  ; ask for the name of the macro
  (kmacro-name-last-macro name)         ; use this name for the macro
  (find-file user-init-file)            ; open ~/.emacs or other user init file
  (goto-char (point-max))               ; go to the end of the .emacs
  (newline)                             ; insert a newline
  (insert-kbd-macro name)               ; copy the macro
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer

;;------------------------------------------------------------------------------
;; Custom keybindings

(global-set-key (kbd "C-x C-u") 'browse-url)

(global-set-key (kbd "C-x \\") 'align-regexp)

(global-set-key (kbd "C-x M-r") 'vr/query-replace)

(global-set-key (kbd "C-c C-a") 'calendar)

(global-set-key (kbd "C-c C-e") 'eval-last-sexp)

;;------------------------------------------------------------------------------
;; Abbrev. Definitions

(setq dabbrev-case-replace nil)
(setq abbrev-mode t)

(define-abbrev-table 'java-mode-abbrev-table
  '(("sysout" "" sysout-skel 0)
    ("sysfor" "" sysfor-skel 0)
    ("cnc" "<code>null</code>" nil 1) ))

(define-skeleton sysout-skel
  "Java standard println statement"
  ""
  > "System.out.println(\"" _ "\");")

(define-skeleton sysfor-skel
  "Java standard println statement"
  ""
  > "System.out.format(\"" _ "%n\");")

(define-abbrev-table 'c-mode-abbrev-table
  '(("pnf" "" printf-skel 0)))

(define-skeleton printf-skel
  "C standard printf statement, with line and file macros."
  ""
  > "printf(\"%s:%d " _ "\\n\", __FILE__, __LINE__);")

(define-abbrev-table 'js2-mode-abbrev-table
  '(("clog" "" clog-skel 0)))

(define-skeleton clog-skel
  "Javascript standard console.log statement."
  ""
  > "console.log(\"" _ "\");")

;;------------------------------------------------------------------------------
;; Key binding overrides

(defvar miken-keys-minor-mode-map (make-keymap) "miken-keys-minor-mode keymap.")

(define-key miken-keys-minor-mode-map (kbd "M-n") 'miken-next-line-five)
(define-key miken-keys-minor-mode-map (kbd "M-p") 'miken-previous-line-five)

(define-minor-mode miken-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  nil " mn" miken-keys-minor-mode-map)

;;------------------------------------------------------------------------------
;; Server

;; for using `emacsclient` in the shell
(server-start)

;;------------------------------------------------------------------------------
;; Exit

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function kill-buffer-query-functions))

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;;------------------------------------------------------------------------------
;; Slime

;(require 'slime-autoloads)
;(slime-setup)
;(setq inferior-lisp-program "~/Applications/cmucl/bin/lisp")

;;------------------------------------------------------------------------------

;;; End .emacs
