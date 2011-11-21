(defun irc-connect ()
  (interactive)
  (require 'erc-join)
  (erc-autojoin-mode 1)
  (erc :server "irc.freenode.net" :port 6667 :nick "HakubJozak")
  (erc :server "irc.3scale.net" :port 61669 :nick "jakub")
  (setq erc-autojoin-channels-alist
        '(("3scale.net" "#dev")
          ("3scale.net" "#jenkins")
          ("3scale.net" "#github")
          ("3scale.net" "#deploy")
          ("3scale.net" "#mtg")
          ("freenode.net" "#gosu")
          ("freenode.net" "#pry")
          ("freenode.net" "#emacs")
          ))
  )

; TODO: DRY
(defun irc-connect-home ()
  (interactive)
  (require 'erc-join)
  (erc-autojoin-mode 1)
  (erc :server "irc.freenode.net" :port 6667 :nick "HakubJozak")
  (setq erc-autojoin-channels-alist
        '(("freenode.net" "#gosu")
          ("freenode.net" "#pry")
          ("freenode.net" "#emacs")
          ))
  )

(defun irc-window-settings ()
  (interactive)

  (split-window-vertically)
  (set-window-buffer (selected-window) "#dev")

  (select-window (next-window))
  (split-window-horizontally)

  (set-window-buffer (selected-window) "#gosu")
  (select-window (next-window))
  (set-window-buffer (selected-window) "#jenkins")

  (select-window (next-window))
  )


(defun rgr/erc-notify-osd (matched-type nick msg)
  (interactive)
  "Hook to add into erc-text-matched-hook in order to remind the user that a message from erc has come their way."
  (when (and (string= matched-type "current-nick") (string-match "\\([^:]*\\).*:\\(.*\\)" msg))
    (let(
	 (text (match-string 2 msg))
	 (from (erc-extract-nick nick)))

      (when text

	(let ((maxlength 128))
	  (if ( > (length msg) maxlength )
	      (setq msg (concat (substring msg 0 20) ".. *snip* .. " (substring msg (- 30)) "."))))

	(setq msg (concat from " : " msg))
        (shell-command  (format "notify-send \"%s\"" msg))))))

(add-hook 'erc-text-matched-hook 'rgr/erc-notify-osd)
