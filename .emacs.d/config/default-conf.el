;; -*- coding: utf-8 -*-

;; (autoload 'my-keybind-conf "my-keybind-conf" nil t)

;;------------------;;
;;     dired設定     ;;
;;------------------;;

;;スペースキーでトグル (FD like)
;;dired.elを読むまではdired-mode-mapがないため、hookを使わないとエラー
(add-hook 'dired-mode-hook
	  '(lambda()
	     (define-key dired-mode-map " " 'dired-toggle-mark)
	     ))
(defun dired-toggle-mark (arg)
  "Toggle the current (or next ARG) files."
  ;; S.Namba Sat Aug 10 12:20:36 1996
  (interactive "P")
  (let ((dired-marker-char
         (if (save-excursion (beginning-of-line)
                             (looking-at " "))
             dired-marker-char ?\040)))
    (dired-mark arg)
    (dired-previous-line 1)))

;;abbrevモードの自動展開無効化
(add-hook 'pre-command-hook
	  (lambda ()
	    (setq abbrev-mode nil)))


;; dabbrev jap
;; http://d.hatena.ne.jp/itouhiro/20091122
(defadvice dabbrev-expand (around jword (arg) activate)
  (interactive "*P")
  (let* ((regexp dabbrev-abbrev-char-regexp)
	 (dabbrev-abbrev-char-regexp regexp)
	 char ch)
    (if (bobp)
	()
      (setq char (char-before)
	    ch (char-to-string char))
      (cond
       ;; ァ〜ヶノ文字ニマッチシテル時ハァ〜ヶガ単語構成文字トスル
       ((string-match "[ァ-ヶー]" ch)
	(setq dabbrev-abbrev-char-regexp "[ァ-ヶー]"))
       ((string-match "[ァ-ンー]" ch)
	(setq dabbrev-abbrev-char-regexp "[ァ-ンー]"))
       ((string-match "[亜-瑤]" ch)
	(setq dabbrev-abbrev-char-regexp "[亜-瑤]"))
       ;; 英数字ニマッチシタラ英数字トハイフン(-)ヲ単語構成文字トスル
       ((string-match "[A-Za-z0-9]" ch)
	;;         (setq dabbrev-abbrev-char-regexp "[A-Za-z0-9]"))
	(setq dabbrev-abbrev-char-regexp "[A-Za-z0-9-]")) ; modified by peccu
       ((eq (char-charset char) 'japanese-jisx0208)
	(setq dabbrev-abbrev-char-regexp
	      (concat "["
		      (char-to-string (make-char 'japanese-jisx0208 48 33))
		      "-"
		      (char-to-string (make-char 'japanese-jisx0208 126 126))
		      "]")))))
    ad-do-it))

;;----------------;;
;;  日付関係      ;;
;;----------------;;


;;; 最終更新日の自動挿入
;;;   ファイルの先頭から 8 行以内に Time-stamp: <> または
;;;   Time-stamp: " " と書いてあれば、セーブ時に自動的に日付が挿入される

(require 'time-stamp)

;; 日本語で日付を入れたくないのでlocaleをCにする
(defun time-stamp-with-locale-c ()
  (let ((system-time-locale "C"))
    (time-stamp)
    nil))

(if (not (memq 'time-stamp-with-locale-c write-file-hooks))
    (add-hook 'write-file-hooks 'time-stamp-with-locale-c))

(setq time-stamp-format "%3a %3b %02d %02H:%02M:%02S %Z %:y")


;; 月/日(曜) 時刻の書式で時計を表示する。
(setq display-time-string-forms
      '(month "/" day "(" dayname ")" 24-hours ":" minutes))
(display-time)


;;timestamp
;; Masatake YAMATO <jet@airlab.cs.ritsumei.ac.jp>
;; Insert current time string;;
;; C-x T でこんな風に: Thu Apr 25 09:58:35 1996
;; C-u C-x T で日本語で: 1996 年 4 月 25 日 09 時 58 分 52 秒 (木曜日)
;; な風に現在時刻が入ります。
;;
;; 日本語に変換する時に current-time-string を分解しているので,
;; そこを変えればお好みのスタイルに加工できると思います。
;;(define-key ctl-x-map "T" 'insert-time)
(define-key ctl-x-map "t" 'insert-time)

(defun insert-time (arg)
  "Insert current time.
With prefix argumet ARG, insert current time string in Japanese."
  (interactive "P")
  (if arg
      (insert (current-time-japanese-string))
    ;;    (insert (current-time-string))))
    (insert ( format-time-string "%T" ( current-time ) ))))
(defun current-time-japanese-string ()
  "Return the current time, as a human-readable JAPANESE string."
  (let ((base (current-time-string))
        (time-j-table
         '(("Jan" . "1") ("Feb" . "2") ("Mar" . "3")
           ("Apr" . "4") ("May" . "5") ("Jun" . "6")
           ("Jul" . "7") ("Aug" . "8") ("Sep" . "9")
           ("Oct" . "10") ("Nov" . "11") ("Dec" . "12")
           ("Mon" . "月") ("Tue" . "火") ("Wed" . "水")
           ("Thu" . "木") ("Fri" . "金") ("Sat" . "土")
           ("Sun" . "日")))
        jadotw jmonth jday jhour jmin jsec jyear
        last)
    (string-match
     (mapconcat
      (lambda (f) f)
      '(
	"\\([a-zA-Z]+\\)\\W+"
	"\\([a-zA-Z]+\\)\\W+"
	"\\([0-9]+\\)\\W+"
	"\\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\)"
	"\\W+\\([0-9]+\\)"
	) "")
     base)
    (setq jadotw (substring base (match-beginning 1) (match-end 1)))
    (setq jmonth (substring base (match-beginning 2) (match-end 2)))
    (setq jday (substring base (match-beginning 3) (match-end 3)))
    (setq jhour (substring base (match-beginning 4) (match-end 4)))
    (setq jmin (substring base (match-beginning 5) (match-end 5)))
    (setq jsec (substring base (match-beginning 6) (match-end 6)))
    (setq jyear (substring base (match-beginning 7) (match-end 7)))
    (setq last (concat jyear "年 "))
    (setq last (concat last (cdr (assoc jmonth time-j-table)) "月 "))
    (setq last (concat last jday "日 "))
    (setq last (concat last jhour "時 "))
    (setq last (concat last jmin "分 "))
    (setq last (concat last jsec "秒 "))
    (setq last (concat last "(" (cdr (assoc jadotw time-j-table)) "曜日)"))
    last))



(provide 'default-conf)
