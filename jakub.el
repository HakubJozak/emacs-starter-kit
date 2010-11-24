; Miscelaneous
(setq require-final-newline nil)
(setq truncate-lines t)
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

(setq my-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
(set-frame-font my-font)

; IDo
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)


; Winner - UNDO and REDO of window configuration
(winner-mode)
(global-set-key (kbd "C-c [") 'winner-undo)
(global-set-key (kbd "C-c ]") 'winner-redo)


; Keys
(global-set-key [f2] 'shell)
(global-set-key [f10] (lambda () (interactive) (open-utility-file  "~/.emacs.d/jakub/snippets/text-mode/ruby-mode/")))
(global-set-key [f11] (lambda () (interactive) (open-utility-file  "~/.emacs.d/jakub.el")))
(global-set-key [f12] (lambda () (interactive) (open-utility-file  "~/.bashrc")))

(define-key global-map [f1] 'help-command)
(define-key global-map "\C-h" 'backward-delete-char)


(defun coding-keymap ()
  (local-set-key (kbd "C-c C-c") 'comment-or-uncomment-region))


(add-hook 'coding-hook 'coding-keymap)


; YASnippets
(add-to-list 'load-path (concat dotfiles-dir "jakub/yasnippet-0.6.1c"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/jakub/snippets")
(setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/no-prompt yas/x-prompt))


; Cucumber.el
(add-to-list 'load-path (concat dotfiles-dir "jakub/cucumber"))
(require 'feature-mode)

; Toggle
(require 'toggle)
(setq toggle-mappings (toggle-style "rails"))
(global-set-key (kbd "C-c C-t") 'toggle-buffer)



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


; Keys
(defun open-utility-file (name)
                        (find-file-other-frame name)
                        (set-frame-font my-font)
                        (toggle-truncate-lines)
)


; Themes hack
(color-theme-twilight)
(zenburn)

