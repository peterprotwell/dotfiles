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
;; Packages

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/") ))

;; Load packages now, not after init
(require 'package)
(setq package-enable-at-startup nil) ;; To avoid initializing twice
(package-initialize)

(defvar my-packages
  '(ag
    auto-complete
    auto-highlight-symbol
    autopair
    buffer-move
    clojure-mode
    coffee-mode
    color-theme
    color-theme-monokai
    discover
    drag-stuff
    emr
    enh-ruby-mode
    expand-region
    feature-mode
    flx-ido
    fuzzy
    haml-mode
    ido-ubiquitous
    js2-mode
    magit
    markdown-mode
    mmm-mode
    multiple-cursors
    projectile
    projectile-rails
    rainbow-mode
    rbenv
    rubocop
    ruby-end
    ruby-hash-syntax
    rspec-mode
    sass-mode
    scss-mode
    slim-mode
    smex
    sr-speedbar
    swift-mode
    visual-regexp
    workgroups
    xkcd
    yaml-mode
    zygospore ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p) ))

;;------------------------------------------------------------------------------
;; Included lisp and required libraries

;; Load lisp files
(defvar emacs-root "~/.emacs.d/")
;; labels is like let for functions
(cl-labels
    ((add-path (p) (add-to-list 'load-path (concat emacs-root p))))
  (add-path "lisp")
  (add-path "themes") )

;;------------------------------------------------------------------------------
;; global settings/modes

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

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; Line numbers
(autoload 'linum-mode "linum" "toggle line numbers on/off" t)
(global-set-key (kbd "C-<f5>") 'linum-mode)

;; Show line/column number in minibuffer
(setq line-number-mode t)
(setq column-number-mode t)

(show-paren-mode 1)

(setq-default cursor-type 'bar)
(setq-default blink-cursor-blinks 0)

(setq-default completion-ignore-case 1)

;; Scrolling
(setq scroll-preserve-screen-position t)
(setq mouse-wheel-progressive-speed nil)

;; Highlight current line
(global-hl-line-mode 1)
;; Highlight current symbol
(auto-highlight-symbol-mode)

(drag-stuff-global-mode)

(setq comment-style 'indent)

;; ...and I know it!
(smex-initialize)

(global-set-key (kbd "s-s") 'isearch-forward-regexp)
(global-set-key (kbd "s-r") 'isearch-backward-regexp)

;; (setq path-to-ctags "/usr/local/bin/ctags")

(global-rbenv-mode)

(autopair-global-mode)

(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward)

(global-set-key (kbd "C-x C-u") 'browse-url)

(require 'discover)
(global-discover-mode 1)

;;------------------------------------------------------------------------------
;; Autocomplete/auto-complete

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)
(global-set-key "\M-/" 'auto-complete)
(global-set-key (kbd "C-M-/") 'ac-fuzzy-complete)

;;------------------------------------------------------------------------------
;; OS settings

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super) )

;;------------------------------------------------------------------------------
;; Color themes

(color-theme-initialize)
(load-library "color-theme-mike")
(load-library "color-theme-molokai")
(load-library "color-theme-railscasts")
(load-library "color-theme-twilight")

(color-theme-railscasts)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (if (string-match "color-theme-*" (buffer-name))
                (rainbow-mode) )))

;;------------------------------------------------------------------------------
;; Window management

(require 'workgroups)
(workgroups-mode 1)
(if (file-exists-p "~/.emacs.d/workgroups")
    (wg-load "~/.emacs.d/workgroups"))
;; (setq wg-query-for-save-on-emacs-exit nil)
;; (add-hook 'kill-emacs-query-functions '(wg-save "~/.emacs.d/workgroups/temp"))

(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

;;------------------------------------------------------------------------------
;; Saving

(global-set-key [f9] 'save-buffer)
(global-set-key [f10] 'save-buffer)
(desktop-save-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)

;;------------------------------------------------------------------------------
;; Projectile

;; Projectile because fuzzy file search
(projectile-global-mode)

(recentf-mode)

;;------------------------------------------------------------------------------
;; Fuzzy file find

(ido-mode 1)
(ido-ubiquitous-mode)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

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
;; multiple cursors

(require 'multiple-cursors)
(global-set-key (kbd "s-SPC") 'set-rectangular-region-anchor)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-?") 'mc/mark-more-like-this-extended)

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

  (defun mike/buffer-directory ()
    (if (buffer-file-name) (file-name-directory (buffer-file-name))
      (getenv "HOME") ))

  ;; Pulled these functions from projectile-speedbar.el
  (defun mike/find-project-root ()
    (if (projectile-project-p) (projectile-project-root)
      (mike/buffer-directory) ))

  (defun mike/speedbar-project-refresh (root-dir)
    "Refresh the context of speedbar based on project root"
    (if (and (not (equal root-dir sr-speedbar-last-refresh-dictionary))
             (not (sr-speedbar-window-p)))
        (setq sr-speedbar-last-refresh-dictionary root-dir) )
    (setq default-directory root-dir)
    (speedbar-refresh) )

  (defun mike/open-current-project-in-speedbar (root-dir)
    "Refresh speedbar to show current project in tree"
    (when (not (sr-speedbar-exist-p))
      (while (windmove-find-other-window 'left)
        (windmove-left) )
      (while (windmove-find-other-window 'up)
        (windmove-up) ))
    (sr-speedbar-toggle)
    (mike/speedbar-project-refresh root-dir) )

  ;; This opens the directory where the calling buffer lives
  (defun mike/speedbar-expand-line-list (&optional arg)
    (when arg
      (re-search-forward (concat " " (car arg) "$"))
      (speedbar-expand-line (car arg))
      (speedbar-next 1)
      (mike/speedbar-expand-line-list (cdr arg)) ))

  (defun mike/speedbar-open-current-buffer-in-tree ()
    (interactive)
    (let* ((root-dir (mike/find-project-root))
           (prev-buffer-directory (mike/buffer-directory))
           (relative-buffer-path (car (cdr (split-string prev-buffer-directory root-dir))))
           (parents (butlast (split-string relative-buffer-path "/")))
           (prev-buffer (buffer-name)) )
      (save-excursion
        (mike/open-current-project-in-speedbar root-dir)
        (select-window (get-buffer-window speedbar-buffer))
        (beginning-of-buffer)
        (mike/speedbar-expand-line-list parents)
        (unless (string= prev-buffer "*SPEEDBAR*")
          (switch-to-buffer  prev-buffer) ))))

  (defun mike/speedbar ()
    (interactive)
    (if (sr-speedbar-exist-p)
        (sr-speedbar-toggle)
      (mike/speedbar-open-current-buffer-in-tree) ))

  (global-set-key [f8] 'mike/speedbar)
)

;;------------------------------------------------------------------------------
;; Refactoring

(define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
(add-hook 'prog-mode-hook 'emr-initialize)

;;------------------------------------------------------------------------------
;; Rails settings

(setq mike/rails-file-types
  '(;; Ruby
    ruby-mode-hook enh-ruby-mode-hook
    ;; JavaScript / CoffeeScript
    javascript-mode-hook js2-mode-hook coffee-mode-hook
    ;; Styles
    css-mode-hook sass-mode-hook scss-mode-hook
    ;; Markup
    html-mode-hook html-erb-mode-hook slim-mode-hook haml-mode-hook yaml-mode-hook))

;; Turn on projectile-rails-mode if we're in a rails project
(dolist (hook mike/rails-file-types)
  (add-hook hook
            (lambda ()
              (if (and
                   (projectile-project-p)
                   (file-exists-p (concat (projectile-project-root) "Gemfile")) )
                  (projectile-rails-mode) ))))

(global-set-key (kbd "M-s-t") 'projectile-find-implementation-or-test-other-window)

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
;; ediff setup

(add-hook 'ediff-quit-hook 'winner-undo)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
;; DA-DA-DA DAAA, daa daa DAAT duh-DAAAAAA!
(if (fboundp 'winner-mode) (winner-mode 1))

;;------------------------------------------------------------------------------
;; Region

(global-set-key "\C-ci" 'indent-region)

(require 'expand-region)
(global-set-key (kbd "s-<up>") 'er/expand-region)
(global-set-key (kbd "s-<down>") 'er/contract-region)

;; Delete region when you start typing
(pending-delete-mode t)

;;------------------------------------------------------------------------------
;; git

(require 'vc-git)
(defun vc-git-annotate-command (file buffer &optional revision)
  "Execute \"git annotate\" on FILE, inserting the contents in BUFFER."
  (vc-git-command buffer 0 file "blame" "--abbrev=5") )
                  ;; " | sed 's/[0-9]*:[0-9]*:[0-9]*//g' | sed 's/-[0-9]\\{3,\\}//g' | tr -s ' '") )

;;------------------------------------------------------------------------------
;; paragraph

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
;; font size / text size

(let ((mike/font-size
       (cond
        ((<= (display-pixel-height) 800) "14")
        ((<= (display-pixel-height) 1200) "18")
        ((<= (display-pixel-height) 1440) "16")
        (t "18") )))
  (set-face-attribute 'default nil :font (concat "Inconsolata-" mike/font-size)) )

;;------------------------------------------------------------------------------
;; Buffer functions and keybindings

(global-set-key "\C-ck" 'kill-buffer-and-window)
(global-set-key "\C-c\C-k" 'kill-buffer-and-window)

(global-set-key "\C-cb" 'switch-to-buffer-other-window)
(global-set-key "\C-c\C-b" 'switch-to-buffer-other-window)

;; Already bound to C-x b
(global-set-key "\C-x\C-b" 'switch-to-buffer)

;; Previously bound to C-x C-b
(global-set-key "\C-x\C-l" 'list-buffers)

;;------------------------------------------------------------------------------
;; Until the dolphin flies and parrots live at sea - shell config

(setq explicit-shell-file-name "/usr/local/bin/zsh")

(defun switch-to-buffer-shell ()
  "Switches to the shell in the current buffer, starting a new shell if needed."
  (interactive)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (switch-to-buffer (ansi-term explicit-shell-file-name)) ))
(global-set-key "\C-x\M-s" 'switch-to-buffer-shell)

;;------------------------------------------------------------------------------
;; Window functions and keybindings

;; Move cursor to other window
(global-set-key (kbd "M-s-h") 'windmove-left)
(global-set-key (kbd "M-s-j") 'windmove-down)
(global-set-key (kbd "M-s-k") 'windmove-up)
(global-set-key (kbd "M-s-l") 'windmove-right)

;; Move buffer to other window
(when (require 'buffer-move nil 'noerror)
  (global-set-key (kbd "M-s-<left>") 'buf-move-left)
  (global-set-key (kbd "M-s-<down>") 'buf-move-down)
  (global-set-key (kbd "M-s-<up>") 'buf-move-up)
  (global-set-key (kbd "M-s-<right>") 'buf-move-right)
)

;; Window resizing
(defun mike/window-taller () (interactive) (enlarge-window 2))
(defun mike/window-shorter () (interactive) (enlarge-window -2))
(defun mike/window-wider () (interactive) (enlarge-window 2 t))
(defun mike/window-narrower () (interactive) (enlarge-window -2 t))

(global-set-key (kbd "C-s-k") 'mike/window-taller)
(global-set-key (kbd "C-s-j") 'mike/window-shorter)
(global-set-key (kbd "C-s-l") 'mike/window-wider)
(global-set-key (kbd "C-s-h") 'mike/window-narrower)

;;------------------------------------------------------------------------------
;; Functions that should exist already

;; Never understood why Emacs doesn't have this function.
(defun rename-file-and-buffer (new-name)
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
(defun move-buffer-file (dir)
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
;; (global-set-key "\C-x\C-w" 'move-buffer-file)
;; (global-set-key "\C-xw" 'move-buffer-file)

;; From the Yegge blog post "Saving Time"
(defun fix-amazon-url ()
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

;; Word count
(defun count-words-buffer ()
  "Counts the number of words in the buffer."
  (interactive)
  (let ((count 0))
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))
        (forward-word 1)
        (setq count (+ 1 count)) )
      (message "buffer contains %d words." count) )))

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t                    (self-insert-command (or arg 1))) ))
;; TODO fix this to work if you're on either side of the paren
(global-set-key (kbd "C-c 9") `goto-match-paren)
(global-set-key (kbd "C-c C-9") `goto-match-paren)

;;------------------------------------------------------------------------------
;; Custom functions

;; This is the greatest and best function ever.
(defun reload ()
  "Reloads the .emacs file"
  (interactive)
  (load-file "~/.emacs") )

(defun yank-line-below ()
  "Yanks text from the buffer as if point was on the next line. Equivalent to
  the command 'C-a C-n C-y'"
  (interactive)
  (save-excursion
    (move-beginning-of-line nil)
    (next-line)
    (yank) ))

(global-set-key (kbd "C-c C-y") 'yank-line-below)

(defun copy-line-below (&optional n)
  "Duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((current-line (thing-at-point 'line)))
      ;; when on last line, insert a newline first
      (if (or (= 1 (forward-line 1))
              (eq (point) (point-max)))
        (insert "\n"))
      ;; now insert as many time as requested
      (while (> n 0)
        (insert current-line)
        (decf n) )))
  (next-line 1))

(global-set-key (kbd "C-c d") 'copy-line-below)
(global-set-key (kbd "C-c C-d") 'copy-line-below)

;; Emulate vim's half-screen scrolling
(defun window-half-height ()
  (max 1 (/ (+ 1 (window-height (selected-window))) 2)) )

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)) )

(global-set-key "\C-v" 'scroll-up-half)

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)) )

(global-set-key "\M-v" 'scroll-down-half)

(defun vim-open-line-above ()
  "Insert a newline above the current line and indent point."
  (interactive)
  (unless (bolp)
    (beginning-of-line) )
  (newline)
  (forward-line -1)
  (indent-according-to-mode) )

(global-set-key (kbd "C-c o") 'vim-open-line-above)
(global-set-key (kbd "C-c C-o") 'vim-open-line-above)

(defun vim-open-line-below ()
  (interactive)
  (end-of-line)
  (newline-and-indent) )

(global-set-key [S-return] 'vim-open-line-below)

;; In the pipe, five-by-five
(defun previous-line-five ()
  (interactive)
  (previous-line 5))

(global-set-key "\M-p" 'previous-line-five)

(defun next-line-five ()
  (interactive)
  (next-line 5) )

(global-set-key "\M-n" 'next-line-five)

(defun xml-format ()
  "Formats a region of XML to look nice"
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t) ))

(defun json-format ()
  (interactive)
  (let ((begin (if mark-active (min (point) (mark)) (point-min)))
        (end (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region begin end
     "python -mjson.tool" (current-buffer) t)))

(defun current-buffer-filepath ()
  "Put the current file path on the clipboard"
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)) )
      (message filename) )))

(global-set-key (kbd "C-c `") 'current-buffer-filepath)

(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not blank, then comment current line.
   Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (not (region-active-p))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key (kbd "M-;") 'comment-dwim-line)

(defun comment-dwim-line-and-move-down (&optional arg)
  "Comment the current line and move to the next line"
  (interactive)
  (comment-dwim-line arg)
  (next-line) )

(global-set-key (kbd "C-M-;") 'comment-dwim-line-and-move-down)

(defun mike/toggle-quotes ()
  "Toggle single quoted string to double or vice versa, and
  flip the internal quotes as well.  Best to run on the first
  character of the string."
  (interactive)
  (save-excursion
    (move-beginning-of-line nil)
    (re-search-forward "[\"']")
    (backward-char 1)
    (let* ((start (point))
           (old-c (char-after start))
           new-c)
      (setq new-c (case old-c
                    (?\" "'")
                    (?\' "\"")))
      (setq old-c (char-to-string old-c))
      (delete-char 1)
      (insert new-c)
      (re-search-forward old-c)
      (backward-char 1)
      (let ((end (point)))
        (delete-char 1)
        (insert new-c)
        (replace-string new-c old-c nil (1+ start) end)))))

(global-set-key (kbd "C-c C-t") 'mike/toggle-quotes)

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

;; Find file
(global-set-key "\C-xf" 'find-file)
;; Find file other window
(global-set-key "\C-cf" 'find-file-other-window)
(global-set-key "\C-c\C-f" 'find-file-other-window)

;; Align text by regex
(global-set-key (kbd "C-c \\") 'align-regexp)

;; Replaces M-x to run commands. I work out!
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)

;; Another Yegge binding
;; (global-set-key "\C-x\M-r" 'query-replace-regexp)
(global-set-key "\C-x\M-r" 'vr/query-replace)

;; Also bound to C-x +
(global-set-key "\C-x=" 'balance-windows)

(global-set-key "\C-c\C-a" 'calendar)

(global-set-key "\M-g" 'goto-line)

(global-set-key "\M-`" 'other-frame)

(global-set-key (kbd "C-c C-e") 'eval-last-sexp)

;;------------------------------------------------------------------------------
;; Abbrev. Definitions

;; Turn on syntax expansion
;;(setq abbrev-file-name "~/.emacs.d/abbrev_file.el")
;;(read-abbrev-file abbrev-file-name t)
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
;; Server

;; for using `emacsclient` in the shell
(server-start)

;;------------------------------------------------------------------------------
;; Slime

;(require 'slime-autoloads)
;(slime-setup)
;(setq inferior-lisp-program "~/Applications/cmucl/bin/lisp")

;;------------------------------------------------------------------------------

;;; End .emacs
