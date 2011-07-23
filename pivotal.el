(defun pivotal-insert-fix ()
  (interactive)
  (let ((BUFFER "*pivotal*")
        stories)
    (call-process "ls" nil BUFFER)

    (with-current-buffer BUFFER
      (setq stories (list 1))

      ;; (while (re-search-forward "^.*$" nil t)
      ;;   (setq stories (cons (match-string 0) stories))
      ;;   (message "--- %s" stories)
      (while (not (eobp))
        (setq l (cons
                 (buffer-string (line-beginning-position) (line-end-position)) l))
        (message "%s" l)
        (forward-line))


      )))



(pivotal-insert-fix)





(defun process-file (file)
   "Read the contents of a file into a temp buffer and then do
 something there.  Line by line :)"
   (setq l (list 1))
   (when (file-readable-p file)
     (with-temp-buffer
       (insert-file-contents file)
       (goto-char (point-min))
       (while (not (eobp))
         (setq l (cons  (buffer-substring-no-properties (line-beginning-position) (line-end-position)) l))
         (forward-line))))
   l)
