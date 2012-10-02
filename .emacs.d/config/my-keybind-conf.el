;; -*- coding: utf-8 -*-

;;----------------;;
;;  キーバインド  ;;
;;----------------;;


(define-key global-map "\M-p" 'mark-paragraph)        ; mark-paragraph
(define-key global-map "\M-h" 'backward-kill-word)    ; backward-kill-word
(define-key global-map "\M-?" 'help-for-help)        ; ヘルプ
(define-key global-map "\C-ci" 'indent-region)       ; インデント
(define-key esc-map "g" 'goto-line)  ;goto-line esc-mapに書き込む=\M-g
(global-set-key "\C-h" 'delete-backward-char)     ; C-h で delete
(global-set-key "\C-o" "\C-e\C-m"); C-o カーソルの下に行を挿入
(global-set-key "\M-o" "\C-p\C-o"); M-o カーソルの上に行を挿入


(global-set-key "\C-m" 'reindent-then-newline-and-indent) ;;リターンキーに対応する
(global-set-key "\C-j" 'newline);只の改行


;;一行取得
(defun my-apply-function-in-current-line (func)
  (let ((begin-point) (end-point))
    (save-excursion
      (beginning-of-line)
      (setq begin-point (point))
      (end-of-line)
      (setq end-point (point))
      (funcall func begin-point end-point)
      )
    )
  )

;; comment/uncomment-regeon
;; C-x ; でコメントアウト
;; C-x : でコメントをはずす
;;(global-set-key "\C-x;" 'comment-region)
(global-set-key "\C-x;" '(lambda (beg end)
			   (interactive "r")
			   (if mark-active
			       ;;(comment-region arg)
			       (comment-region beg end)
			     ;;(quote comment-region)
			     (my-apply-function-in-current-line 'comment-region)
			     )))
(global-set-key "\C-x:" '(lambda (beg end)
			   (interactive "r")
			   (if mark-active
			       (uncomment-region beg end)
			     (my-apply-function-in-current-line 'uncomment-region)
			     )))
;;(fset 'uncomment-region "\C-u\C-[xcomment-region\C-m")
;;(global-set-key "\C-x:" 'uncomment-region)


;; C-x p で C-x o の逆の動作を実現する。
(define-key ctl-x-map "p"
  #'(lambda (arg) (interactive "p") (other-window (- arg))))

;; C-k(kill-line) で行末の改行も含めて kill する
(setq kill-whole-line t)

;;行頭まで削除処理
(defun backward-kill-ling (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0)
  )
(global-set-key (kbd "C-S-k") 'backward-kill-ling)

;;ミニバッファの履歴をC-p, C-nで辿れるように
(define-key  minibuffer-local-must-match-map "\C-p" 'previous-history-element)
(define-key  minibuffer-local-must-match-map "\C-n" 'next-history-element)
(define-key  minibuffer-local-completion-map "\C-p" 'previous-history-element)
(define-key  minibuffer-local-completion-map "\C-n" 'next-history-element)
(define-key  minibuffer-local-map "\C-p" 'previous-history-element)
(define-key  minibuffer-local-map "\C-n" 'next-history-element)


;;C-zでの最小化の無効
;;(define-key global-map "\C-z" 'nil)

(provide 'my-keybind-conf)
