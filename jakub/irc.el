(defun irc-connect ()
  (interactive)
  (require 'erc-join)
  (erc-autojoin-mode 1)

  (require 'tls)
  (erc :server "irc.freenode.net" :port 6667 :nick "HakubJozak" )
;  (erc :server "irc.3scale.net" :port 61669 :nick "jakub" :password "hypnotoad")
; irc.3scale.net
  (erc-tls :server "ec2-184-72-192-26.compute-1.amazonaws.com" :port 61670 :nick "jakub" :password "hypnotoad")

  (setq erc-autojoin-channels-alist
        '(("3scale.net" "#dev")
          ("3scale.net" "#lmao")
          ("3scale.net" "#dev-resistance")
          ("3scale.net" "#jenkins")
          ("3scale.net" "#github")
          ("3scale.net" "#deploy")
          ("3scale.net" "#mtg")
          ("freenode.net" "#gosu")
          ("freenode.net" "#pry")
          ("freenode.net" "#emacs")
          ))
  )

()

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

  (set-window-buffer (selected-window) "#lmao")
  (select-window (next-window))
  (set-window-buffer (selected-window) "#jenkins")

  (select-window (next-window))
  )


(defun jakub/erc-notify-osd (matched-type nick msg)
  (interactive)
  "Hook to add into erc-text-matched-hook in order to remind the user that a message from erc has come their way."
  (when (and
         (string= matched-type "current-nick")
         (string-match "\\([^:]*\\).*:\\(.*\\)" msg)
         )
    (let(
	 (text (match-string 2 msg))
	 (from (erc-extract-nick nick)))

      (when text

	(let ((maxlength 512))
	  (if ( > (length msg) maxlength )
	      (setq msg (concat (substring msg 0 20) "..." (substring msg (- 30)) "."))))

	(setq msg (concat from " : " msg))
        (shell-command  (format "notify-send --hint=int:transient:1 \"%s\"" (shell-quote-argument msg)))))))


(add-hook 'erc-text-matched-hook 'jakub/erc-notify-osd)


(defun 3scale-browse-issue (arg)
  (interactive)
  (browse-url (concat "https://github.com/3scale/system/issues/" arg)))

(eval-after-load "erc-button" '(add-to-list 'erc-button-alist '("#\\([0-9]+\\)" 0 t  3scale-browse-issue 1)))
