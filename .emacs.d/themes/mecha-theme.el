;;; mecha-theme.el --- Emacs theme with a dark background.

;; Copyright (C) 2015, Mike Nichols

;; Author: Mike Nichols
;; URL: https://github.com/mikenichols/mecha-theme
;; Version: 0.1
;; Package-Requires: ((emacs "24"))
;; Created with emacs-theme-generator, https://github.com/mswift42/theme-creator.


;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of Emacs.

;;; Commentary:

;;; Code:

(deftheme mecha)
(let ((class '((class color) (min-colors 89)))

      (grey0    "#ffffff")
      (grey1    "#e5e5e5")
      (grey2    "#d4d4d4")
      (grey3    "#c3c3c3")
      (grey4    "#b2b2b2")
      (grey5    "#a1a1a1")
      (grey6    "#808080")
      (grey7    "#575757")
      (grey8    "#484848")
      (grey9    "#3a3a3a")
      (grey10   "#2b2b2b")
      (grey11   "#1c1c1c")

      (grey9001 "#504f48")

      (orange1  "#ffddbb")
      (var      "#ffddbb")
      (orange2  "#ffbb40")
      (orange3  "#ff7400")
      (warning  "#ff7400")
      (orange4  "#bf7130")
      (orange5  "#543210"))

  (custom-theme-set-faces
   'mecha
   `(default ((,class (:background ,grey11 :foreground ,grey1))))
   `(font-lock-builtin-face ((,class (:foreground ,orange1))))
   `(font-lock-comment-face ((,class (:foreground ,grey7))))
   `(font-lock-negation-char-face ((,class (:foreground ,grey6))))
   `(font-lock-reference-face ((,class (:foreground ,grey6))))
   `(font-lock-constant-face ((,class (:foreground ,grey6))))
   `(font-lock-doc-face ((,class (:foreground ,grey7))))
   `(font-lock-function-name-face ((,class (:foreground ,orange2 :bold t))))
   `(font-lock-keyword-face ((,class (:bold ,class :foreground ,grey4))))
   `(font-lock-string-face ((,class (:foreground ,orange4))))
   `(enh-ruby-string-delimiter-face ((,class (:foreground ,orange4))))
   `(enh-ruby-op-face ((,class (:foreground ,grey7))))
   `(elixir-operator-face ((,class (:foreground ,grey7))))
   `(elixir-atom-face ((,class (:foreground ,orange1))))
   `(font-lock-type-face ((,class (:foreground ,orange3 ))))
   `(font-lock-variable-name-face ((,class (:foreground ,var))))
   `(font-lock-warning-face ((,class (:foreground ,warning :background ,grey10))))
   `(region ((,class (:background ,grey9001 :foreground ,grey0))))
   `(highlight ((,class (:foreground ,grey3 :background ,grey9))))
   `(hl-line ((,class (:background  ,grey10))))
   `(fringe ((,class (:background ,grey11 :foreground ,grey5))))
   `(cursor ((,class (:foreground ,grey0))))
   `(show-paren-match-face ((,class (:background ,warning))))
   `(isearch ((,class (:bold t :foreground ,grey11 :background ,orange3))))
   `(mode-line ((,class (:box (:line-width 1 :color nil) :bold t :foreground ,grey2 :background ,grey9))))
   `(mode-line-inactive ((,class (:box (:line-width 1 :color nil :style pressed-button) :foreground ,grey6 :background ,grey11 :weight normal))))
   `(mode-line-buffer-id ((,class (:bold t :foreground ,orange2 :background nil))))
   `(mode-line-highlight ((,class (:foreground ,grey4 :box nil :weight bold))))
   `(mode-line-emphasis ((,class (:foreground ,grey1))))
   `(vertical-border ((,class (:foreground ,grey3))))
   `(minibuffer-prompt ((,class (:bold t :foreground ,grey1))))
   `(default-italic ((,class (:italic t))))
   `(link ((,class (:foreground ,grey6 :underline t))))
   `(org-code ((,class (:foreground ,grey2))))
   `(org-hide ((,class (:foreground ,grey5))))
   `(org-level-1 ((,class (:bold t :foreground ,grey2 :height 1.1))))
   `(org-level-2 ((,class (:bold nil :foreground ,grey3))))
   `(org-level-3 ((,class (:bold t :foreground ,grey5))))
   `(org-level-4 ((,class (:bold nil :foreground ,grey8))))
   `(org-date ((,class (:underline t :foreground ,var) )))
   `(org-footnote  ((,class (:underline t :foreground ,grey5))))
   `(org-link ((,class (:underline t :foreground ,orange3 ))))
   `(org-special-keyword ((,class (:foreground ,orange2))))
   `(org-block ((,class (:foreground ,grey3))))
   `(org-quote ((,class (:inherit org-block :slant italic))))
   `(org-verse ((,class (:inherit org-block :slant italic))))
   `(org-todo ((,class (:box (:line-width 1 :color ,grey3) :foreground ,grey4 :bold t))))
   `(org-done ((,class (:box (:line-width 1 :color ,grey9) :bold t :foreground ,grey8))))
   `(org-warning ((,class (:underline t :foreground ,warning))))
   `(org-agenda-structure ((,class (:weight bold :foreground ,grey3 :box (:color ,grey5) :background ,grey9))))
   `(org-agenda-date ((,class (:foreground ,var :height 1.1 ))))
   `(org-agenda-date-weekend ((,class (:weight normal :foreground ,grey5))))
   `(org-agenda-date-today ((,class (:weight bold :foreground ,grey4 :height 1.4))))
   `(org-agenda-done ((,class (:foreground ,grey8))))
   `(org-scheduled ((,class (:foreground ,orange3))))
   `(org-scheduled-today ((,class (:foreground ,orange2 :weight bold :height 1.2))))
   `(org-ellipsis ((,class (:foreground ,orange1))))
   `(org-verbatim ((,class (:foreground ,grey5))))
   `(org-document-info-keyword ((,class (:foreground ,orange2))))
   `(font-latex-bold-face ((,class (:foreground ,orange3))))
   `(font-latex-italic-face ((,class (:foreground ,grey7 :italic t))))
   `(font-latex-string-face ((,class (:foreground ,orange4))))
   `(font-latex-match-reference-keywords ((,class (:foreground ,grey6))))
   `(font-latex-match-variable-keywords ((,class (:foreground ,var))))
   `(ido-only-match ((,class (:foreground ,warning))))
   `(org-sexp-date ((,class (:foreground ,grey5))))
   `(ido-first-match ((,class (:foreground ,grey4 :bold t))))
   `(gnus-header-content ((,class (:foreground ,grey4))))
   `(gnus-header-from ((,class (:foreground ,var))))
   `(gnus-header-name ((,class (:foreground ,orange3))))
   `(gnus-header-subject ((,class (:foreground ,orange2 :bold t))))
   `(mu4e-view-url-number-face ((,class (:foreground ,orange3))))
   `(mu4e-cited-1-face ((,class (:foreground ,grey2))))
   `(mu4e-cited-7-face ((,class (:foreground ,grey3))))
   `(mu4e-header-marks-face ((,class (:foreground ,orange3))))
   `(ffap ((,class (:foreground ,grey5))))
   `(js2-private-function-call ((,class (:foreground ,grey6))))
   `(js2-jsdoc-html-tag-delimiter ((,class (:foreground ,orange4))))
   `(js2-jsdoc-html-tag-name ((,class (:foreground ,grey6))))
   `(js2-external-variable ((,class (:foreground ,orange3  ))))
   `(js2-function-param ((,class (:foreground ,grey6))))
   `(js2-jsdoc-value ((,class (:foreground ,orange4))))
   `(js2-private-member ((,class (:foreground ,grey3))))
   `(js3-warning-face ((,class (:underline ,grey4))))
   `(js3-error-face ((,class (:underline ,warning))))
   `(js3-external-variable-face ((,class (:foreground ,var))))
   `(js3-function-param-face ((,class (:foreground ,grey7))))
   `(js3-jsdoc-tag-face ((,class (:foreground ,grey4))))
   `(js3-instance-member-face ((,class (:foreground ,grey6))))
   `(warning ((,class (:foreground ,warning))))
   `(ac-completion-face ((,class (:underline t :foreground ,grey4))))
   `(info-quoted-name ((,class (:foreground ,orange1))))
   `(info-string ((,class (:foreground ,orange4))))
   `(icompletep-determined ((,class :foreground ,orange1)))
   `(undo-tree-visualizer-current-face ((,class :foreground ,orange1)))
   `(undo-tree-visualizer-default-face ((,class :foreground ,grey2)))
   `(undo-tree-visualizer-unmodified-face ((,class :foreground ,var)))
   `(undo-tree-visualizer-register-face ((,class :foreground ,orange3)))
   `(slime-repl-inputed-output-face ((,class (:foreground ,orange3))))
   `(trailing-whitespace ((,class :foreground nil :background ,warning)))
   `(rainbow-delimiters-depth-1-face ((,class :foreground ,grey1)))
   `(rainbow-delimiters-depth-2-face ((,class :foreground ,orange3)))
   `(rainbow-delimiters-depth-3-face ((,class :foreground ,var)))
   `(rainbow-delimiters-depth-4-face ((,class :foreground ,grey6)))
   `(rainbow-delimiters-depth-5-face ((,class :foreground ,grey4)))
   `(rainbow-delimiters-depth-6-face ((,class :foreground ,grey1)))
   `(rainbow-delimiters-depth-7-face ((,class :foreground ,orange3)))
   `(rainbow-delimiters-depth-8-face ((,class :foreground ,var)))
   `(magit-item-highlight ((,class :background ,grey9)))
   `(magit-section-heading        ((,class (:foreground ,grey4 :weight bold))))
   `(magit-hunk-heading           ((,class (:background ,grey9))))
   `(magit-section-highlight      ((,class (:background ,grey10))))
   `(magit-hunk-heading-highlight ((,class (:background ,grey9))))
   `(magit-diff-context-highlight ((,class (:background ,grey9 :foreground ,grey3))))
   `(magit-diffstat-added   ((,class (:foreground ,orange3))))
   `(magit-diffstat-removed ((,class (:foreground ,var))))
   `(magit-process-ok ((,class (:foreground ,orange2 :weight bold))))
   `(magit-process-ng ((,class (:foreground ,warning :weight bold))))
   `(magit-branch ((,class (:foreground ,grey6 :weight bold))))
   `(magit-log-author ((,class (:foreground ,grey3))))
   `(magit-hash ((,class (:foreground ,grey2))))
   `(magit-diff-file-header ((,class (:foreground ,grey2 :background ,grey9))))
   `(lazy-highlight ((,class (:foreground ,grey9 :background ,orange1))))
   `(term ((,class (:foreground ,grey1 :background ,grey11))))
   `(term-color-black ((,class (:foreground ,grey9 :background ,grey9))))
   `(term-color-blue ((,class (:foreground ,grey3 :background ,grey3))))
   `(term-color-red ((,class (:foreground ,orange3 :background ,orange3))))
   `(term-color-green ((,class (:foreground ,orange4 :background ,orange4))))
   `(term-color-yellow ((,class (:foreground ,orange1 :background ,orange1))))
   `(term-color-magenta ((,class (:foreground ,orange2 :background ,orange2))))
   `(term-color-cyan ((,class (:foreground ,orange4 :background ,orange4))))
   `(term-color-white ((,class (:foreground ,grey2 :background ,grey2))))
   `(rainbow-delimiters-unmatched-face ((,class :foreground ,warning)))
   `(helm-header ((,class (:foreground ,grey2 :background ,grey11 :underline nil :box nil))))
   `(helm-source-header ((,class (:foreground ,grey4 :background ,grey11 :underline nil :weight bold))))
   `(helm-selection ((,class (:background ,grey10 :underline nil))))
   `(helm-selection-line ((,class (:background ,grey10))))
   `(helm-visible-mark ((,class (:foreground ,grey11 :background ,grey9))))
   `(helm-candidate-number ((,class (:foreground ,grey11 :background ,grey1))))
   `(helm-separator ((,class (:foreground ,orange3 :background ,grey11))))
   `(helm-time-zone-current ((,class (:foreground ,orange1 :background ,grey11))))
   `(helm-time-zone-home ((,class (:foreground ,orange3 :background ,grey11))))
   `(helm-buffer-not-saved ((,class (:foreground ,orange3 :background ,grey11))))
   `(helm-buffer-process ((,class (:foreground ,orange1 :background ,grey11))))
   `(helm-buffer-saved-out ((,class (:foreground ,grey1 :background ,grey11))))
   `(helm-buffer-size ((,class (:foreground ,grey1 :background ,grey11))))
   `(helm-ff-directory ((,class (:foreground ,orange2 :background ,grey11 :weight bold))))
   `(helm-ff-file ((,class (:foreground ,grey1 :background ,grey11 :weight normal))))
   `(helm-ff-executable ((,class (:foreground ,grey6 :background ,grey11 :weight normal))))
   `(helm-ff-invalid-symlink ((,class (:foreground ,grey7 :background ,grey11 :weight bold))))
   `(helm-ff-symlink ((,class (:foreground ,grey4 :background ,grey11 :weight bold))))
   `(helm-ff-prefix ((,class (:foreground ,grey11 :background ,grey4 :weight normal))))
   `(helm-grep-cmd-line ((,class (:foreground ,grey1 :background ,grey11))))
   `(helm-grep-file ((,class (:foreground ,grey1 :background ,grey11))))
   `(helm-grep-finish ((,class (:foreground ,grey2 :background ,grey11))))
   `(helm-grep-lineno ((,class (:foreground ,grey1 :background ,grey11))))
   `(helm-grep-match ((,class (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((,class (:foreground ,orange2 :background ,grey11))))
   `(helm-moccur-buffer ((,class (:foreground ,orange2 :background ,grey11))))
   `(helm-source-go-package-godoc-description ((,class (:foreground ,orange4))))
   `(helm-bookmark-w3m ((,class (:foreground ,orange3))))
   `(company-echo-common ((,class (:foreground ,grey11 :background ,grey1))))
   `(company-preview ((,class (:background ,grey11 :foreground ,grey6))))
   `(company-preview-common ((,class (:foreground ,grey10 :foreground ,grey3))))
   `(company-preview-search ((,class (:foreground ,orange3 :background ,grey11))))
   `(company-scrollbar-bg ((,class (:background ,grey9))))
   `(company-scrollbar-fg ((,class (:foreground ,grey4))))
   `(company-tooltip ((,class (:foreground ,grey2 :background ,grey11 :bold t))))
   `(company-tooltop-annotation ((,class (:foreground ,grey6))))
   `(company-tooltip-common ((,class ( :foreground ,grey3))))
   `(company-tooltip-common-selection ((,class (:foreground ,orange4))))
   `(company-tooltip-mouse ((,class (:inherit highlight))))
   `(company-tooltip-selection ((,class (:background ,grey9 :foreground ,grey3))))
   `(company-template-field ((,class (:inherit region))))
   `(web-mode-builtin-face ((,class (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((,class (:inherit ,font-lock-constant-face))))
   `(web-mode-keyword-face ((,class (:foreground ,grey4))))
   `(web-mode-doctype-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-function-name-face ((,class (:inherit ,font-lock-function-name-face))))
   `(web-mode-string-face ((,class (:foreground ,orange4))))
   `(web-mode-type-face ((,class (:inherit ,font-lock-type-face))))
   `(web-mode-html-attr-name-face ((,class (:foreground ,orange2))))
   `(web-mode-html-attr-value-face ((,class (:foreground ,grey4))))
   `(web-mode-warning-face ((,class (:inherit ,font-lock-warning-face))))
   `(web-mode-html-tag-face ((,class (:foreground ,orange1))))
   `(jde-java-font-lock-package-face ((t (:foreground ,var))))
   `(jde-java-font-lock-public-face ((t (:foreground ,grey4))))
   `(jde-java-font-lock-private-face ((t (:foreground ,grey4))))
   `(jde-java-font-lock-constant-face ((t (:foreground ,grey6))))
   `(jde-java-font-lock-modifier-face ((t (:foreground ,grey7))))
   `(jde-jave-font-lock-protected-face ((t (:foreground ,grey4))))
   `(jde-java-font-lock-number-face ((t (:foreground ,var))))

   `(wg-mode-line-face ((,class (:foreground ,orange1))))
   `(wg-divider-face ((,class (:foreground ,orange1))))
   `(ahs-plugin-defalt-face ((,class (:background ,orange5))))
   `(ahs-face ((,class (:background ,grey10))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
	       (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mecha)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; mecha-theme.el ends here
