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
  "Make the mark's position stand out by means of a one-character-long overlay.
   If the value of variable `mmv-is-mark-visible' is nil, the mark will be
   invisible."
  (create-mmv-overlay)
  (let ((mark-position (mark t)))
    (cond
     ((null mark-position) (delete-overlay mmv-mark-overlay))
     ((and (< mark-position (point-max))
           (not (eq ?\n (char-after mark-position))))
      (overlay-put mmv-mark-overlay 'after-string nil)
      (move-overlay mmv-mark-overlay mark-position (1+ mark-position)))
     (t
      ; This branch is called when the mark is at the end of a line or at the
      ; end of the buffer. We use a bit of trickery to avoid the higlight
      ; extending from the mark all the way to the right end of the frame.
      (overlay-put mmv-mark-overlay 'after-string
                   (propertize " " 'face (overlay-get mmv-mark-overlay 'face)))
      (move-overlay mmv-mark-overlay mark-position mark-position)))))

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
