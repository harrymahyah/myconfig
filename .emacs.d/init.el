;; -*- coding: utf-8 -*-

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/packages")

(require 'default-conf)

;;(autoload 'my-keybind "my-keybind-conf" nil t)


;;; 標準機能を使った設定（os 切り替えを除く)

(global-whitespace-mode 0)

;; turn on font-lock mode
(global-font-lock-mode t)

;; enable visual feedback on selections
(setq transient-mark-mode t)

(setq indent-tabs-mode t)


(set-language-environment 'Japanese)

;;; 開始時のメッセージスキップ
(setq inhibit-startup-message t)
(put 'upcase-region 'disabled nil)


;; menu bar を消す。
(menu-bar-mode -1)

;; 最初に開くフォルダ
(cd "~/")

;; window-system only
(if window-system
    (progn
     ;; tool bar を消す。
     (tool-bar-mode 0)
     ;;scroll-bar を有効に
     (set-scroll-bar-mode 'right)
     )
  )

;; encoding
(setq default-coding-systems 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq-default file-name-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq universal-coding-system-argument 'utf-8)
;; (set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8)

;; switching by os
;;(autoload 'platform-p)
(when (require 'platform-p nil t)

  (when platform-darwin-p
    (setq ns-command-modifier (quote meta))
    (setq ns-alternate-modifier (quote super))
    (set-buffer-file-coding-system 'utf-8-mac)
    )
  (when platform-linux-p
    (set-buffer-file-coding-system 'utf-8-unix)
    )
)
;;yes no を y n に
(fset 'yes-or-no-p 'y-or-n-p)

;;read-onlyファイルをviewモードで開く
(setq view-read-only t)

;;;カーソルの一行移動
(setq scroll-conservatively 35
;;;      scroll-margin 0
      scroll-margin 10
      ;;scroll-step 1 ;;conservativelyと一緒
      )

;;ファイルが変更された場合に、自動的に読み込む
(global-auto-revert-mode t)

;;redoのキーバインド変更
(global-set-key [(control \?)] 'redo)



;;ファイルの最終行にnewlineを追加
(setq require-final-newline t)

;;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;;タブ幅の変更
(set 'tab-width 4)
;;(setq tab-width 4)

;;ウィンドウ折り返し
(setq truncate-lines nil)

;; 分割時の文字折り返し
(setq truncate-partial-width-windows nil)


;; バックアップファイルを一か所に集める
(setq make-backup-files t)
(setq backup-directory "~/.bak")
(if (not (file-directory-p backup-directory))
  (make-directory backup-directory)
)

(if (and (boundp 'backup-directory)
         (not (fboundp 'make-backup-file-name-original)))
    (progn
      (fset 'make-backup-file-name-original
            (symbol-function 'make-backup-file-name))
      (defun make-backup-file-name (filename)
        (if (and (file-exists-p (expand-file-name backup-directory))
                 (file-directory-p (expand-file-name backup-directory)))
            (concat (expand-file-name backup-directory)
                    "/" (file-name-nondirectory filename) "~")
          (make-backup-file-name-original filename)))))



;;;全スペやらタブやらの表示、色など
(defface my-face-b-2 '((t (:background "darkslategray"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
			      (if font-lock-mode
				  nil
				(font-lock-mode t))) t)



;;　モードラインフォーマットの編集 行とか列とかの表示
(setq-default mode-line-format
	      '("-"
		mode-line-mule-info
		mode-line-modified
					;mode-line-frame-identification
		mode-line-buffer-identification
		" "
		(line-number-mode "L%l-")
		(column-number-mode "C%c-")
		" "
		global-mode-string
		" %[("
		mode-name
		mode-line-process
		minor-mode-alist
		"%n" ")%]-"
		(which-func-mode ("" which-func-format "-"))
					;(line-number-mode "L%l-")
					;(column-number-mode "C%c-")
		(-3 . "%p")
					;"-%-"
		)
	      )

(setq mode-line-frame-identification " ")


;;------------------;;
;;  scratch 設定    ;;
;;------------------;;


;;;scratchバッファを削除不能に
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*"を作成してbuffer-listに放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
		   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
	  ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list()
  (mapcar (function buffer-name)(buffer-list)))

(add-hook 'kill-buffer-query-functions
	  ;; *scratch*バッファでkill-bufferしたら内容を消去するだけ
	  (function (lambda ()
		      (if (string= "*scratch*" (buffer-name))
			  (progn (my-make-scratch 0) nil)
			t))))

(add-hook 'after-save-hook
	  ;;*scratch*バッファを保存したら、新しく作る
	  (function (lambda ()
		      (unless (member "*scratch*" (my-buffer-name-list))
			(my-make-scratch 1)))))



;;; 外部パッケージ依存？

;;;redoを独立

(autoload 'redo+ "redo+" nil t)
;;(require 'redo+)

;;過去のundoをredoしない
(setq undo-no-redo t)

;;redo のリミット設定（大きめでないとバッファが壊れます）
(setq undo-limit 60000)
(setq undo-strong-limit 90000)


;; 同名のファイルを開いたとき、上位のディレクトリを表示(ユニークになるまで)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;-----------------------------------;;
;;    　　　　カーソル位置保存          ;;
;;-----------------------------------;;
(load "saveplace")
(setq-default save-place t)

;;-----------------------------------;;
;;    session&minibuffer-isearch     ;;
;;-----------------------------------;;

;;ミニバッファ履歴リストのMAX：tなら無限
(setq history-length 1000)

;;session.el
;;ミニバッファ履歴をファイル保存
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
	session-globals-include '((kill-ring 50)
				  (session-file-alist 500 t)
				  (file-name-history 10000)))
  (add-hook 'after-init-hook 'session-initialize)

  ;;前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1))
;;minibuf-isearch
;;minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)


;;-----------------;;
;;  kill-ring拡張  ;;
;;-----------------;;

(setq kill-ring-max 100)

;;browse-kill-ring
;;(require 'browse-kill-ring)
;;(global-set-key (kbd "C-c k") 'browse-kill-ring)

(when (locate-library "browse-kill-ring")

  (autoload 'browse-kill-ring "browse-kill-ring"
    "interactively insert items from kill-ring" t)

  (define-key ctl-x-map "\C-y" 'browse-kill-ring);実質\C-x\C-y

  ;;(setq browse-kill-ring-quit-action 'kill-and-delete-window)

  ;;終了時にウィンドウを閉じないように
  ;;終了時にウィンドウを閉じないように
  (setq browse-kill-ring-quit-action 'bury-buffer)

  ;;見た目
  (if (not window-system)
      (setq browse-kill-ring-display-style 'one-line
	    browse-kill-ring-resize-window nil)
    (defface separator '((t (:foreground "slate gray" :bold t))) nil)
    (setq browse-kill-ring-separator "\n--separator-------------------"
	  browse-kill-ring-face 'separator
	  browse-kill-ring-highlight-current-entry t
	  browse-kill-ring-highlight-inserted-item t
	  ;;browse-kill-ring-resize-window
	  ;;(cons (- (frame-height) (window-height) 1) window-min-height)
	  )))

;;memorize window size
(defun my-window-size-save ()
  (let* ((rlist (frame-parameters (selected-frame)))
	 (ilist initial-frame-alist)
	 (nCHeight (frame-height))
	 (nCWidth (frame-width))
	 (tMargin (if (integerp (cdr (assoc 'top rlist)))
		      (cdr (assoc 'top rlist)) 0))
	 (lMargin (if (integerp (cdr (assoc 'left rlist)))
		      (cdr (assoc 'left rlist)) 0))
	 buf
	 (file "~/.framesize.el"))
    (if (get-file-buffer (expand-file-name file))
	(setq buf (get-file-buffer (expand-file-name file)))
      (setq buf (find-file-noselect file)))
    (set-buffer buf)
    (erase-buffer)
    (insert (concat
	     ;; 初期値をいじるよりも modify-frame-parameters
	     ;; で変えるだけの方がいい?
	     "(delete 'width initial-frame-alist)\n"
	     "(delete 'height initial-frame-alist)\n"
	     "(delete 'top initial-frame-alist)\n"
	     "(delete 'left initial-frame-alist)\n"
	     "(setq initial-frame-alist (append (list\n"
	     "'(width . " (int-to-string nCWidth) ")\n"
	     "'(height . " (int-to-string nCHeight) ")\n"
	     "'(top . " (int-to-string tMargin) ")\n"
	     "'(left . " (int-to-string lMargin) "))\n"
	     "initial-frame-alist))\n"
	     ;;"(setq default-frame-alist initial-frame-alist)"
	     ))
    (save-buffer)
    ))

(defun my-window-size-load ()
  (let* ((file "~/.framesize.el"))
    (if (file-exists-p file)
	(load file))))

(my-window-size-load)

;; Call the function above at C-x C-c.
(defadvice save-buffers-kill-emacs
  (before save-frame-size activate)
  (my-window-size-save))

;; current line copy
(defun duplicate-line (&optional numlines)
  "One line is duplicated wherever there is a cursor."
  (interactive "p")
  (let* ((col (current-column))
	 (bol (progn (beginning-of-line) (point)))
	 (eol (progn (end-of-line) (point)))
	 (line (buffer-substring bol eol)))
    (while (> numlines 0)
      (insert "\n" line)
      (setq numlines (- numlines 1)))
    (move-to-column col)))

;;(define-key esc-map "Y" 'duplicate-line)
(define-key global-map "\C-\M-y" 'duplicate-line)

;; setting of window movement
;;(global-set-key [C next] 'other-window)
(global-set-key [(C >)] 'other-window)
(defun back-window ()
  (interactive)
  (other-window -1))
;;(global-set-key [C prior] 'back-window)
(global-set-key [(C <)] 'back-window)

;; setting of buffer switching

;;C-S-, デ前ノバッファ
(global-set-key '[(C ?,)] 'previous-buffer)

;; C-S-. デ次ノバッファ
(global-set-key '[(C ?.)] 'next-buffer)



;;revive.el

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
;; (define-key ctl-x-map "r" 'resume)                        ; C-x F で復元
;; (define-key ctl-x-map "w" 'wipe)                          ; C-x K で Kill
(define-key ctl-x-map "s" 'save-current-configuration)                          ; C-x s で 状態保存
;;(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存

;;dsvn.el
;; (autoload 'svn-status "dsvn" "Run `svn status'." t)
;; (autoload 'svn-update "dsvn" "Run `svn update'." t)

;; revive.el で複数の状態を選択的に保存
(defvar revive-file-dir "~/")
(defvar revive-file-prefix ".revive_state_")
;;(defvar revive-file-postfix "state")

(when (require 'revive nil t)

  (defun save-named-buffer-status (name)
    (interactive "Msave state name: ");;ミニバッファで読んだ文字列

    (let ((original-file revive:configuration-file))
      
      ;; revive.el の保存ファイル名を一時的に変更
      (setq revive:configuration-file
	    (concat revive-file-dir	revive-file-prefix name	"_"
		    (format-time-string "%Y-%m-%dT%T" (current-time))))

      ;; 保存
      (save-current-configuration )

      ;; 保存ファイル名を元に戻す
      (setq revive:configuration-file original-file)))

  (defun resume-named-buffer-status ()
    (interactive)
    (let ((state-name)(state-timestamp)(state-list)
	  (original-file revive:configuration-file)(state)(state-key)
	  (files  (directory-files
		   revive-file-dir nil (concat "^" revive-file-prefix ".*"))))

      ;; 保存ファイル名のリストを作成
      (mapcar '(lambda (n)
		 (add-to-list 'state-list
			      (list (substring n (length revive-file-prefix)))))
			      ;; (list (substring n (length revive-file-prefix) -20) (substring n -19 nil))))
	      files)
      
      (setq state (completing-read "revive state name: " state-list))
      ;; (setq state-key (completing-read "revive state name: " state-list))
      ;; (setq state (assoc state-key state-list))
      
      (if state
	  (progn 
	    (setq revive:configuration-file
		  (concat revive-file-dir revive-file-prefix state ))
		  ;; (concat revive-file-dir revive-file-prefix (car state) "_" (car (cdr state)) ))
	    (resume)
	    (setq revive:configuration-file original-file)))))
  
  (defun wipe-and-named-resume ()
    (interactive)
    (wipe)
    (resume-named-buffer-status))
  )


;;ispellで日本語をスキップ
;;(add-to-list 'ispell-skip-region-alist '("[^\t\f\n\r\040-\176]+"))
(eval-after-load "ispell"
  '(setq ispell-skip-region-alist (cons '("[^\000-\377]")
					ispell-skip-region-alist)))

;; (vc-mode )
;;setting install-elisp
(autoload 'install-elisp "install-elisp" nil t)
;;(require 'install-elisp)
					;;(setq install-elisp-repository-directory "~/.emacs.d")


;;選択範囲ノ挙動ヲ windows ニ :: cua-mode
(cua-selection-mode t)
;; (CUA-mode 'emacs)
;; (setq CUA-mode-normal-cursor-color "red")
;; (setq CUA-mode-overwrite-cursor-color "yellow")
;; (setq CUA-mode-read-only-cursor-color "green")


;;ハイライトノフェイス設定
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray7"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")

(set-face-underline-p 'hlline-face t)
(setq hl-line-face 'hlline-face)
(hl-line-mode t)

;;tramp
(require 'tramp)


;;default browser setting
(setq browse-url-browser-function 'browse-url-firefox)

;;jap calender setting
(require 'calendar)
(setq  number-of-diary-entries 31)
(define-key calendar-mode-map "f" 'calendar-forward-day)
(define-key calendar-mode-map "n" 'calendar-forward-day)
(define-key calendar-mode-map "b" 'calendar-backward-day)
(setq mark-holidays-in-calendar t)
;; (install-elisp "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
(when (require 'japanese-holidays nil t)
;;(autoload 'japanese-holidays "japanese-holidays" nil t)
(setq calendar-holidays
      (append japanese-holidays local-holidays other-holidays))
)
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)


;;物理行移動
(defun previous-window-line (n)
  (interactive "p")
  (let ((cur-col
         (- (current-column)
            (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook)
  )
(defun next-window-line (n)
  (interactive "p")
  (let ((cur-col
         (- (current-column)
            (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook)
  )

;;rect-mark
(autoload 'rect-mark "rect-mark" nil t)


;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))
