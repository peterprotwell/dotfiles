;;; color-theme-railscasts.el --- Railscasts color theme for GNU Emacs.

;; Inspired by the brilliant Railscasts theme for TextMate

;; Copyright (C) 2009 Oleg Shaldybin <oleg.shaldybin@gmail.com>

;; Author: Oleg Shaldybin
;; Adapted-By: Yesudeep Mangalapilly
;; Keywords: railscasts color theme
;; URL: https://github.com/olegshaldybin/color-theme-railscasts
;; Version: 0.0.2
;; Package-Requires: ((color-theme "6.6.1"))

;; This file is NOT a part of GNU Emacs.

;;; License:

;; MIT License
;; -----------
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use,
;; copy, modify, merge, publish, distribute, sublicense, and/or
;; sell copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following
;; conditions:
;;
;; The above copyright notice and this permission notice shall
;; be included in all copies or substantial portions of the
;; Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;; OTHER DEALINGS IN THE SOFTWARE.

;;; Usage:
;;
;; The path in the third line is the path to the railscasts theme .el file.
;; (require 'color-theme)
;; (color-theme-initialize)
;; (load-file "~/.emacs.d/site-lisp/themes/color-theme-railscasts.el")
;; (color-theme-railscasts)

;;; Code:

(eval-when-compile
  (require 'color-theme))

(defun color-theme-railscasts ()
  (interactive)
  (color-theme-install
   '(color-theme-railscasts

     ((background-color . "#232323")
      (border-color . "#232323")
      (background-mode . dark)
      (mouse-color . "sienna1") ; avallark
      (cursor-color . "#FFFFFF") ;avallark
      (foreground-color . "#E6E1DC"))

     (default ((t (:background "#232323" :foreground "#F8F8F8")))) ;avallark
     (blue ((t (:foreground "blue")))) ; avallark
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (fringe ((t (:background "#232323"))))
     (font-lock-builtin-face ((t (:foreground "#C8C8FF"))))
     (font-lock-comment-face ((t (:foreground "#BC9458"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#BC9458"))))
     (font-lock-constant-face ((t (:foreground "#6D9CBE"))))
     (font-lock-doc-string-face ((t (:foreground "#A5C261"))))
     (font-lock-function-name-face ((t (:foreground "#FFC66D"))))
     (font-lock-keyword-face ((t (:foreground "#CC7833"))))
     (font-lock-preprocessor-face ((t (:foreground "#CC7833"))))
     (enh-ruby-op-face ((t (:foreground "#CC7833"))))
     (font-lock-reference-face ((t (:foreground "LightSteelBlue"))))
     (font-lock-string-face ((t (:foreground "#A5C261"))))
     (enh-ruby-string-delimiter-face ((t (:foreground "#A5C261"))))
     (font-lock-type-face ((t (:foreground "#6D9CBE"))))
     (font-lock-variable-name-face ((t (:foreground "#C8C8FF"))))
     (font-lock-warning-face ((t (:foreground "Pink"))))
     (paren-face-match-light ((t (:foreground "#FFC66D" :background "#555577"))))
     (show-paren-match ((t (:foreground nil :background "#3070FF"))))
     (show-paren-mismatch ((t (:foreground "#00FF00" :background "#FF00FF"))))
     (highlight ((t (:background "#2a2a2a"))))
     (hl-line ((t (:foreground nil :background "#2a2a2a"))))
     (ahs-face ((t (:foreground nil :background "#38383f"))))
     (ahs-plugin-defalt-face ((t (:foreground nil :background "#604050"))))
     (italic ((t (:italic t))))
     (modeline ((t (:background "#A5BAF1" :foreground "black"))))
     (modeline-buffer-id ((t (:background "#A5BAF1" :foreground "black"))))
     (modeline-mousable ((t (:background "#A5BAF1" :foreground "black"))))
     (modeline-mousable-minor-mode ((t (:background "#A5BAF1" :foreground "black"))))
     (region ((t (:foreground "white" :background "#555577"))))
     (primary-selection ((t (:background "#555577"))))
     (secondary-selection ((t (:background "DarkSlateBlue"))))
     (zmacs-region ((t (:background "#555577"))))
     (flymake-errline ((t (:background "LightSalmon" :foreground "black"))))
     (flymake-warnline ((t (:background "LightSteelBlue" :foreground "black"))))

     (isearch ((t (:bold t :foreground "#333333" :background "#22EEEE"))))
     (lazy-highlight ((t (:foreground "#333333" :background "#f6e05c"))))

     (speedbar-button-face ((t (:foreground "#e0e0e0"))))
     (speedbar-directory-face ((t (:foreground "#50B0FF"))))
     (speedbar-file-face ((t (:foreground "#e0e0e0"))))
     (speedbar-highlight-face ((t (:foreground "#FFFFFF" :background "#505050"))))
     (speedbar-selected-face ((t (:foreground "#f6e05c"))))
     (speedbar-separator-face ((t (:foreground "#e0e0e0" :background "#007f00"))))
     (speedbar-tag-face ((t (:foreground "#22a222"))))

     (wg-mode-line-face ((t (:foreground nil))))
     (wg-divider-face ((t (:foreground nil))))

     (rbenv-active-ruby-face ((t (:foreground "#CC3838"))))

     (term-color-red ((t (:foreground "#d83b31"))))
     (term-color-green ((t (:foreground "#8cf900"))))
     (term-color-blue ((t (:foreground "#76a8f0"))))
     (term-color-yellow ((t (:foreground "#ffee9c"))))

     (underline ((t (:underline t))))
     (minibuffer-prompt ((t (:bold t :foreground "#FF6600")))) )))


(provide 'color-theme-railscasts)

;;; color-theme-railscasts.el ends here
