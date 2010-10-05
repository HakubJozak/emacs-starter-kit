; Miscelaneous
(setq require-final-newline nil)
(setq truncate-lines t)

(remove-hook 'text-mode-hook 'turn-on-auto-fill)

(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map "\C-t" 'help-command)

(setq my-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
(set-frame-font my-font)

(global-set-key [f10] (lambda () (interactive) (open-utility-file  "~/.emacs.d/snippets/text-mode/ruby-mode/")))
(global-set-key [f11] (lambda () (interactive) (open-utility-file  "~/.emacs.d/jakub.el")))
(global-set-key [f12] (lambda () (interactive) (open-utility-file  "~/.bashrc")))


; YASnippets
(add-to-list 'load-path (concat dotfiles-dir "jakub/yasnippet-0.6.1c"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/jakub/snippets")
(setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/no-prompt yas/x-prompt))


; Copy & Paste
(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
(setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection
(setq select-active-regions t) ;  active region sets primary X11 selection
(global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.
(setq yank-pop-change-selection t)  ; makes rotating the kill ring change the X11 clipboard.

; Fixing Dired
(defun mydired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (mydired-sort))


(defun open-utility-file (name)
                        (find-file-other-frame name)
                        (set-frame-font my-font)
                        (toggle-truncate-lines)
)



