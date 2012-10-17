;;shell-pop 設定
(when (require 'shell-pop nil t)

  ;; (require 'term)

  ;;shell-pop の multi-term 対応
  ;;(add-to-list 'shell-pop-internal-mode-list '("multi-term" "*terminal*" '(lambda () (multi-term))))
  ;;(shell-pop-set-internal-mode "multi-term")
  ;;  (shell-pop-set-internal-mode "ansi-term")

  ;;(shell-pop-set-internal-mode-shell "/bin/bash")

  (defun my-shell-call (&optional arg)
    (interactive "P")
    ;;(funcall (eval shell-pop-internal-mode-func)) ;;ansi-term が無い場合は有効化(win用)
    (ansi-term "/bin/bash") ;; ansi-term が無い場合は無効化(linux用)
    ))

(defun get-buffer-list-regexp (arg)

  (let ((buffer-name-list)(regexp-str)(term-list '())(match-point))
    (setq buffer-name-list (mapcar 'buffer-name (buffer-list)))
    (mapcar #'(lambda (n)
		(setq match-point (string-match arg n))
		(if match-point
		    (add-to-list 'term-list n)
		  ))
	    buffer-name-list)
    term-list))

(defun change-term-buffer (&optional arg)
  (interactive "P")
  (let ((current-buffer-name)(term-buffer-lists) (temp-list)
	(term-buffer-list-size) (temp-list-size))

    ;;カレントバッファノ名前ヲ取得
    (setq current-buffer-name (buffer-name (current-buffer)))

    ;;ansi-termノバッファ名ヲ抽出シテソート
    ;;ココデ、正規表現文字列ヲshell-popノlistカラ持ッテクレバ、ヨリshell-pop拡張ラシクナリソゲ。
    ;;メンドイノデヤラナイ。　書式ハ(eval shell-pop-internal-mode-buffer) ミタイナ感ジカ。
    ;; windows では ansi-term 使えないので、term で引っ掛けないとだめ
    ;; 逆に Linux では ansi-term に戻さないとうまくいかない
    ;; どうしたものか
    
    (setq term-buffer-lists (sort (get-buffer-list-regexp "\*ansi-term\*") 'string<))
    ;;(setq term-buffer-lists (sort (get-buffer-list-regexp "\*term\*") 'string<))

    (if (not term-buffer-lists)
	print "no term exist"
	)

    ;;引数ガアレバ、逆リストニ変換
    (if arg
	(setq term-buffer-lists (nreverse term-buffer-lists)))

    ;;debug
    ;; (print term-buffer-lists)

    (setq term-buffer-list-size (length term-buffer-lists))

    ;;2個以上バッファガアレバ、移動
    (if (> term-buffer-list-size 1)
	(progn
	  (setq temp-list (member current-buffer-name term-buffer-lists))
	  (setq temp-list-size (length temp-list))
	  (if (= temp-list-size 1)
	      (switch-to-buffer (nth 0 term-buffer-lists))
	    (switch-to-buffer (nth 1 temp-list))
	    )
	  ;;(switch-to-buffer (nth 1 (member current-buffer-name term-buffer-lists)))
	  )
      (my-shell-call)
      )
    ;;term-buffer-lists
    ))

(defvar my-last-term-buffer "")

(defadvice shell-pop (around my-shell-pop-around)
  "this extend the pop-out condition of shell-pop"
  (let ((current-buffer-name)(term-buffer-lists))
    (setq current-buffer-name (buffer-name (current-buffer)))
    (setq term-buffer-lists (get-buffer-list-regexp "\*ansi-term\*"))
    (if (member current-buffer-name term-buffer-lists)
	(shell-pop-out)
      ad-do-it
      )
    ))
(ad-activate 'shell-pop)

(defun my-shell-pop-current (&optional arg)
  (interactive "P")
  (let ((current-buffer-name buffer-file-name))

    (shell-pop)
    (if current-buffer-name
	(term-send-raw-string (concat "cd " (file-name-directory current-buffer-name)  "\n"))
      ))
  )

;; 複数のターミナルがある場合、次に移動
(defun change-term-next (arg)
  (interactive "P")
  (change-term-buffer)
  )
;; 複数のターミナルがある場合、前に移動
(defun change-term-prior (arg)
  (interactive "P")
  (change-term-buffer 'reverse)
  )

(global-set-key "\C-t" 'shell-pop)
(global-set-key [(C S t)] 'my-shell-pop-current)

;; custumize term-mode-hook
(defun my-term-hook ()

  (when (require 'shell-pop nil t)
    (define-key term-raw-map "\C-t" 'shell-pop)
    (define-key term-raw-map [(C S t)] 'my-shell-call)
    (define-key term-raw-map [(C prior)] 'change-term-prior)
    (define-key term-raw-map [(C next)] 'change-term-next)

    ;;(define-key term-raw-map (kbd "C-x t") 'my-shell-call)

    )
  
  (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
  (define-key term-raw-map (kbd "C-y") 'term-paste)
  (define-key term-raw-map [(C S k)] nil)

  (set (make-local-variable 'hl-line-mode) nil)
  (set (make-local-variable 'attentive-pair-completion) nil)
  (set (make-local-variable 'scroll-margin) 0)
  )
;;(add-hook 'term-mode-hook 'my-term-hook)
;; (defvar multi-term-after-hook nil)
;;(add-hook 'multi-term-after-hook 'my-term-hook)

;; (defadvice multi-term (after my-term-after-advice ())
;;   "run hook as after advice"
;;   (run-hooks 'my-term-hook))
;; (ad-activate 'multi-term)

;; (setq multi-term-color-vector
;;         [unspecified "black" "#ff5555" "#55ff55" "#ffff55" "#5555ff"
;;          "#ff55ff" "#55ffff" "white"])

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook 'my-term-hook)
(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

;;ansi-term font-color setting
(setq ansi-term-color-vector
      [unspecified "black" "#ff5555" "#55ff55" "#ffff55" "#5555ff"
		   "#ff55ff" "#55ffff" "white"])

(provide 'my-shell-conf)
