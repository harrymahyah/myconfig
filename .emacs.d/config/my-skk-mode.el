;; skk 設定
(setq skk-preload t)
;;(require 'skk)

;;sticky-shift

(setq skk-sticky-key ";")
;;(setq skk-sticky-key [SPC])

(setq skk-use-kakasi nil)

;; skk-auto-fill-mode と skk-mode のバインドを逆に
(global-set-key "\C-xj" 'skk-mode)

;; (defvar sticky-key ";")
;; (defvar sticky-list
;;   '(("a" . "A")("b" . "B")("c" . "C")("d" . "D")("e" . "E")("f" . "F")("g" . "G")
;;     ("h" . "H")("i" . "I")("j" . "J")("k" . "K")("l" . "L")("m" . "M")("n" . "N")
;;     ("o" . "O")("p" . "P")("q" . "Q")("r" . "R")("s" . "S")("t" . "T")("u" . "U")
;;     ("v" . "V")("w" . "W")("x" . "X")("y" . "Y")("z" . "Z")
;;     ("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")("6" . "^")("7" . "&")
;;     ("8" . "*")("9" . "(")("0" . ")")
;;     ("`" . "~")("[" . "{")("]" . "}")("-" . "_")("=" . "+")("," . "<")("." . ">")
;;     ("/" . "?")(";" . ":")("'" . "\"")("\\" . "|")
;;     ))
;; (defvar sticky-map (make-sparse-keymap))
;; (define-key global-map sticky-key sticky-map)
;; ;; (define-key skk-j-mode-map sticky-key sticky-map)
;; (mapcar (lambda (pair)
;;           (define-key sticky-map (car pair)
;;             `(lambda()(interactive)
;;                (setq unread-command-events
;;                      (cons ,(string-to-char (cdr pair)) unread-command-events)))))
;;         sticky-list)
;; (define-key sticky-map sticky-key '(lambda ()(interactive)(insert sticky-key)))

;; ;; sticky-shift skk 用設定
;; (eval-after-load "skk"
;;   '(progn
;;      (define-key skk-j-mode-map sticky-key sticky-map)
;;      (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
;;      (define-key skk-abbrev-mode-map sticky-key sticky-map)

;;      ;; 英数カラノ復帰ヲ SPC-j デ可能ナヨウニ
;;      ;; (space-chord-define skk-latin-mode-map "j" 'skk-kakutei)
;;      ;; (key-chord-define skk-latin-mode-map "ij" 'skk-kakutei)
;;      ;; (key-chord-define skk-jisx0208-latin-mode-map "ij" 'skk-kakutei)
;;      ;;(key-chord-define skk-lookup-prefix-and-kana-map "ij" 'skk-kakutei)
;;      ))
;; (eval-after-load "skk-isearch"
;;   '(define-key skk-isearch-mode-map sticky-key sticky-map))


;; コメント中でのみ有効化
(add-hook 'skk-load-hook
	  (lambda ()
	    (require 'context-skk)
	    ))


(when (require 'skk nil t)
  ;; 英数からの復帰を SPC-j で可能なように
  (space-chord-define skk-latin-mode-map "j" 'skk-kakutei)
  ;; (key-chord-define skk-latin-mode-map "ij" nil)

  (key-chord-define skk-j-mode-map "fj" 'skk-sticky-set-henkan-point)
  (key-chord-define skk-j-mode-map "fk" 'skk-katakana-region)
  (key-chord-define skk-j-mode-map "fh" 'skk-hiragana-region)

  (space-chord-define skk-j-mode-map "j" 'skk-kakutei)
  (space-chord-define skk-j-mode-map "k" 'skk-set-henkan-point-subr)

  ;; (space-chord-define skk-j-mode-map "k" 'skk-katakana-region)
  ;; (space-chord-define skk-j-mode-map "h" 'skk-hiragana-region)

  ;;(key-chord-define skk-j-mode-map "fj" 'skk-insert)
  ;; (key-chord-define skk-j-mode-map "fd" '(lambda () (interactive)
  ;; 							 (insert-char "Q")
  ;;					 ))
  ;;(key-chord-define skk-lookup-prefix-and-kana-map "ij" 'skk-kakutei)

  ;;   (define-key skk-j-mode-map sticky-key sticky-map)
  ;;   (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
  ;;   (define-key skk-abbrev-mode-map sticky-key sticky-map)

  ;;   ;; 英数からの復帰を SPC-j で可能なように
  ;;   (space-chord-define skk-latin-mode-map "j" 'skk-kakutei)
  ;;   (key-chord-define skk-latin-mode-map "ij" 'skk-kakutei)

  ;; ;;  (when (require 'skk-isearch nil t)
  ;;   (define-key skk-isearch-mode-map sticky-key sticky-map);;)
  )

