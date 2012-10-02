;; speedbar 
(when (require 'speedbar nil t)

  ;;speedbar setting
  (speedbar-add-supported-extension ".rb")
  (speedbar-add-supported-extension ".txt")
  (speedbar-add-supported-extension ".org")
  (speedbar-add-supported-extension ".dot")
  (speedbar-add-supported-extension ".xml")
  (speedbar-add-supported-extension ".scala")
  ;;(speedbar-add-supported-extension ".php")
  ;;(speedbar-add-supported-extension ".clp")

  (defun my-speedbar-expand-line ()
    (interactive)
    (if (= (point-max) (progn (speedbar-expand-line) (point-max)))
	(save-current-buffer
	  (speedbar-edit-line)
	  ;;(other-window)
	  (next-window)
	  )))

  (define-key speedbar-file-key-map "a" 'speedbar-toggle-show-all-files)
  ;; (define-key speedbar-file-key-map [right] 'my-speedbar-expand-line)
  ;; (define-key speedbar-file-key-map "\C-f" 'my-speedbar-expand-line)
  ;; (define-key speedbar-file-key-map [left] 'speedbar-contract-line)
  ;; (define-key speedbar-file-key-map "\C-b" 'speedbar-contract-line)

  ;; (define-key speedbar-file-key-map [backspace] 'speedbar-up-directory)
  ;; (define-key speedbar-file-key-map "\C-h" 'speedbar-up-directory)

  ;; vi like binding
  (define-key speedbar-file-key-map "j" 'next-line)
  (define-key speedbar-file-key-map "k" 'previous-line)
  (define-key speedbar-file-key-map "l" 'my-speedbar-expand-line)
  (define-key speedbar-file-key-map "h" 'speedbar-up-directory)


  ;;same frame speedbar
  (when (require 'sr-speedbar nil t)

    ;;sr-speedbar width
    ;; 設定自体ハ効イテルンダケド、ナンカ初期化時ニ有効ニナラナイ
    ;; emacsノ挙動ヲ調ベナイト判ランネ。
    (setq sr-speedbar-width 30)
    (setq sr-speedbar-width-x 30)
    (setq sr-speedbar-width-console 30)
    (setq sr-speedbar-right-side nil) ;; ペインを左に表示

    ;;sr-speedbar 起動
    (sr-speedbar-open)
    (sr-speedbar-toggle)

    (defun my-speedbar-toggle (arg)
      (interactive "P")
      (sr-speedbar-toggle)
      ;;(next-window)
      (other-window 1)
      ;;(switch-to-buffer "*SPEEDBAR*")
      ;;(select-window "*SPEEDBAR*")

      )

    ;;(define-key global-map "\C-ct" 'sr-speedbar-toggle)
    (define-key global-map "\C-ct" 'my-speedbar-toggle)

    )
  ;;(require 'speedbar-extension)
  );;speedbar
