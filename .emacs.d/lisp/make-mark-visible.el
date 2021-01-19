;;;; Make the mark visible, and the visibility toggleable. ('mmv' means 'make
;;;; mark visible'.) By Patrick Gundlach, Teemu Leisti, and Stefan.

(defface mmv-face
  '((t :background "maroon2" :foreground "white"))
  "Face used for showing the mark's position.")

(defvar-local mmv-mark-overlay nil
  "The overlay for showing the mark's position.")

(defvar-local mmv-is-mark-visible t
  "The overlay is visible only when this variable's value is t.")

(defun mmv-draw-mark (&rest _)
  "Make the mark's position stand out by means of an overlay.
   If the value of variable `mmv-is-mark-visible' is nil, the mark will be
   invisible."
  (create-mmv-overlay)
  (let ((mark-position (mark t)))
    (if (null mark-position)
        (delete-overlay mmv-mark-overlay)
      (let* ((mmv-raw-string (cond ((> mark-position (buffer-size)) "^D")
                                   ((eq ?\n (char-after mark-position)) "^M")))
             (mmv-display-string (if mmv-raw-string
                                     (propertize mmv-raw-string 'face (overlay-get mmv-mark-overlay 'face))))
             (mmv-position (+ mark-position (if mmv-display-string 0 1))))
        (overlay-put mmv-mark-overlay 'after-string mmv-display-string)
        (move-overlay mmv-mark-overlay mark-position mmv-position)))))

(add-hook 'pre-redisplay-functions #'mmv-draw-mark)

(defun mmv-toggle-mark-visibility ()
  "Toggles the mark's visiblity and redraws it (whether invisible or visible)."
  (interactive)
  (setq mmv-is-mark-visible (not mmv-is-mark-visible))
  (update-mmv-face)
  (mmv-draw-mark))

(defun update-mmv-face ()
  "Updates the mark overlay face to match the mark visibility state."
  (create-mmv-overlay)
  (if mmv-is-mark-visible
      (overlay-put mmv-mark-overlay 'face 'mmv-face)
    (overlay-put mmv-mark-overlay 'face 'default)))

(defun create-mmv-overlay ()
  (unless mmv-mark-overlay
    (setq mmv-mark-overlay (make-overlay 0 0 nil t))
    (overlay-put mmv-mark-overlay 'face 'mmv-face)))

(update-mmv-face)

(global-set-key (kbd "C-c v") 'mmv-toggle-mark-visibility)
