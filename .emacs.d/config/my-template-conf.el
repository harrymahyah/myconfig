;; zen-coding settings
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'html-mode-hook 'zencoding-mode)
(add-hook 'text-mode-hook 'zencoding-mode)
(define-key zencoding-mode-keymap "\C-z e" 'zencoding-expand-line)

;; yasnippet settings
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(when (require 'yasnippet nil t)
;;(require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/yasnippet/snippets")
  (yas/load-directory "~/.emacs.d/yasnippets-rails/rails-snippets")
  (setq yas/prompt-functions '(yas/dropdown-prompt))
  )

(provide 'my-template-conf)
