;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(type-of package-activated-list)
(length package-activated-list)
(length (remove-duplicates package-activated-list))

(print (cdadr package-alist))

(miken-package-get-deps (car (remove-duplicates package-activated-list)))

(defun miken-package-get-dependees (dependency)
  (interactive)
  (cl-loop for pkg in (remove-duplicates package-activated-list)
           for deps = (miken-package-get-deps pkg)
           when (memq dependency deps)
           collect pkg))

(miken-package-get-dependees 'dash)

(dolist (pkg package-activated-list)
  (package-desc-reqs (cadr (assq pkg package-alist))))

;; (package-desc-reqs
;;  [cl-struct-package-desc aggressive-indent (20160501 1911) "Minor mode to aggressively keep your code always indented" ((emacs (24 1)) (cl-lib (0 5))) nil nil "/Users/mike/.emacs.d/elpa/aggressive-indent-20160501.1911" ((:keywords "indent" "lisp" "maint" "tools") (:url . "https://github.com/Malabarba/aggressive-indent-mode")) nil])

;; From package.el#package--get-deps:1703
(defun miken-package-get-deps (pkg &optional only)
  (interactive)
  (let* ((pkg-desc (cadr (assq pkg package-alist)))
         (direct-deps (cl-loop for p in (package-desc-reqs pkg-desc)
                               for name = (car p)
                               when (assq name package-alist)
                               collect name))
         (indirect-deps (unless (eq only 'direct)
                          (remove-duplicates
                           (cl-loop for p in direct-deps
                                    append (miken-package-get-deps p))))))
    (cl-case only
      (direct   direct-deps)
      (separate (list direct-deps indirect-deps))
      (indirect indirect-deps)
      (t        (remove-duplicates (append direct-deps indirect-deps))))))

(miken-package-get-deps 'ag)
(miken-package-get-deps 'magit)

;; This will take us from activated => magic pkg-desc => reqs
(car package-activated-list)
(assq (car package-activated-list) package-alist)
(cadr (assq (car package-activated-list) package-alist))
(package-desc-reqs (cadr (assq (car package-activated-list) package-alist)))

(car (assq 'dash (package-desc-reqs (cadr (assq 'magit package-alist)))))

(assq 'dash (miken-package-get-deps 'magit))
