;;------------------------------------------------------------------------------
;; Color-theme

(eval-when-compile
  (require 'color-theme))

;; Set color-theme to awesome!
(defun color-theme-mike ()
  "Awesome color theme by Mike Nichols"
  (interactive)
  (color-theme-install
   '(color-theme-mike

     ;; Super-light grey on Dark grey
     ((cursor-color . "#ffffff")
      (foreground-color . "#e0e0e0")
      (background-color . "#141414")
      (background-mode . dark))

     (Bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))

     (font-lock-builtin-face ((t (:foreground "#119988")))) ;; Perl Teal
     (font-lock-comment-face ((t (:foreground "#777")))) ;; Comment Grey
     (font-lock-comment-delimiter-face ((t (:foreground "#777"))))
     (font-lock-constant-face ((t (:foreground "#257025")))) ;; Forest Green
     (font-lock-doc-string-face ((t (:foreground "#257025")))) ;; Army Green
     (font-lock-doc-face ((t (:foreground "#e66400")))) ;; Python Orange
     (font-lock-function-name-face ((t (:foreground "#e0e0e0"))))
     (font-lock-keyword-face ((t (:foreground "#1d5eb2")))) ;; Cool Blue (29, 94, 178)
     (font-lock-preprocessor-face ((t (:foreground "#604070")))) ;; Alligator Purple
     (font-lock-reference-face ((t (:foreground "#e0e0e0"))))
     (font-lock-string-face ((t (:foreground "#70ddff"))))
     (font-lock-type-face ((t (:foreground "#1d5eb2"))))
     (font-lock-variable-name-face ((t (:foreground "#e0e0e0"))))
     (font-lock-warning-face ((t (:bold t :foreground "yellow"))))
     (hl-line ((t (:foreground nil :background "#19191b")))) ;; Charcoal Blue
     (js2-function-param-face ((t (:foreground "#ffbbdd")))) ;; Lavender
     (isearch ((t (:foreground "#000013" :background "#00eeee")))) ;; Cyan
     (lazy-highlight ((t (:foreground "#000013" :background "#f6e05c")))) ;; Mellow Yellow
     (mode-line ((t (:foreground "#e0e0e0" :background "#333333"))))
     (region ((t (:foreground nil :background "#403040")))) ;; Subtle Maroon
     (semantic-decoration-on-unparsed-includes ((t (:foreground nil :background "#202000"))))
     (semantic-decoration-on-unknown-includes ((t (:foreground nil :background "#200020"))))
     (show-paren-match-face ((t (:foreground "#00cc00" :background "#ff4bff")))) ;; Watermelon Man
     (show-paren-mismatch ((t (:foreground "#ccccff" :background "#b22222"))))
     (speedbar-button-face ((t (:foreground "#e0e0e0"))))
     (speedbar-directory-face ((t (:foreground "#70ddff"))))
     (speedbar-file-face ((t (:foreground "#e0e0e0"))))
     (speedbar-highlight-face ((t (:foreground "#e0e0e0" :background "#1d5eb2"))))
     (speedbar-selected-face ((t (:foreground "#f6e05c"))))
     (speedbar-separator-face ((t (:foreground "#e0e0e0" :background "#007f00"))))
     (speedbar-tag-face ((t (:foreground "#22a222")))))))

;; Set color-theme to awesome-light!
(defun color-theme-mike-light ()
  "Awesome light color theme by Mike Nichols."
  (interactive)
  (color-theme-install
   '(color-theme-mike
     ;; black on white
     ((cursor-color . "#000000")
      (foreground-color . "#101010")
      (background-color . "#e0e0e0")
      (background-mode . light))

     (Bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))

     (font-lock-builtin-face ((t (:foreground "#00787a")))) ;; Perl Teal (darker)
     (font-lock-comment-face ((t (:foreground "#007f00")))) ;; Forest Green
     (font-lock-comment-delimiter-face ((t (:foreground "#007f00"))))
     (font-lock-constant-face ((t (:foreground "#b22222")))) ;; Brick Red
     (font-lock-doc-string-face ((t (:foreground "#007f00")))) ;; Army Green
     (font-lock-doc-face ((t (:foreground "#e66400")))) ;; Python Orange
     (font-lock-reference-face ((t (:foreground "#e0e0e0"))))
     (font-lock-function-name-face ((t (:foreground "#101010"))))
     (font-lock-keyword-face ((t (:foreground "#0d4ea2")))) ;; Cool Blue (darker)
     (font-lock-preprocessor-face ((t (:foreground "#604070")))) ;; Alligator Purple
     (font-lock-string-face ((t (:foreground "#004090")))) ;; Stevey Blue (darker)
     (font-lock-type-face ((t (:foreground "#0d4ea2"))))
     (font-lock-variable-name-face ((t (:foreground "#101010"))))
     (font-lock-warning-face ((t (:bold t :foreground "yellow"))))
     (hl-line ((t (:foreground nil :background "#d8d8da")))) ;; Light Charcoal Blue
     (isearch ((t (:foreground "#000013" :background "#00eeee")))) ;; Cyan
     (lazy-highlight ((t (:foreground "#000013" :background "#f6e05c")))) ;; Mellow Yellow
     (mode-line ((t (:foreground "#101010" :background "#bbbbbb"))))
     (region ((t (:foreground nil :background "#ffccdd")))) ;; Subtle Maroon
     (show-paren-match-face ((t (:bold t :foreground "#00cc00" :background "#ff4bff")))) ;; Watermelon Man
     (show-paren-mismatch ((t (:foreground "#ccccff" :background "#b22222"))))
     (speedbar-button-face ((t (:foreground "#e0e0e0"))))
     (speedbar-directory-face ((t (:foreground "#70ddff"))))
     (speedbar-file-face ((t (:foreground "#e0e0e0"))))
     (speedbar-highlight-face ((t (:foreground "#e0e0e0" :background "#1d5eb2"))))
     (speedbar-selected-face ((t (:foreground "#f6e05c"))))
     (speedbar-separator-face ((t (:foreground "#e0e0e0" :background "#007f00"))))
     (speedbar-tag-face ((t (:foreground "#22a222")))))))


(provide 'color-theme-mike)
