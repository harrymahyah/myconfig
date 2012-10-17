;;key-chord
(when (require 'key-chord nil t)
  ;; (setq key-chord-two-keys-delay 0.04)
  (setq key-chord-two-keys-delay 0.08);;5�ե졩
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode)
  ;; (key-chord-define-global "nb" 'anything)
  ;; (key-chord-define-global "nb" '(lambda ()
  ;; 								   (interactive)
  ;; 								   (setq my-anything-active-p t)
  ;; 								   anything))
  ;;(key-chord-define-global "kl" 'org-cycle)

  ;;space-chord
  (require 'space-chord)

  (space-chord-define-global "b" 'anything)
  (space-chord-define-global "k" 'anything-show-kill-ring)

  (space-chord-define-global "f" 'find-file)
  (space-chord-define-global "g" 'keyboard-quit)
  (space-chord-define-global "n" 'next-window-line)

  (space-chord-define-global "o" 'org-cycle)

  ;;(space-chord-define skk-latin-mode-map "j" 'skk-kakutei)

  )

(provide 'my-key-chord-conf)
