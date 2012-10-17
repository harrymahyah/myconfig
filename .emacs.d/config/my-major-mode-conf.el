;;----------------;;
;;  モード設定    ;;
;;----------------;;


;;require設定
;; (require 'php-mode)
;; (require 'html-helper-mode)
;; (require 'mmm-mode)
;; (require 'gemini)
;;(setq-default gemini nil)



;;dabbrev の複数バッファ対応化
;;各フックに追加してください
(defvar my-dabbrev-source-list '())

(defun my-dabbrev-multiplex-function ()
  "Return a list of buffers using in dabbrev"

  (let (l (bl (buffer-list)))
    (dolist (elt bl)
      (save-excursion
	(set-buffer elt)
	(when (memq major-mode my-dabbrev-source-list)
	  (setq l (cons elt l)))))
    l))

(defun my-dabbrev-setting-function (arg)
  (make-local-variable 'my-dabbrev-source-list)
  (setq my-dabbrev-source-list arg)
  (set (make-local-variable 'dabbrev-check-all-buffers) nil)
  (set (make-local-variable 'dabbrev-select-buffers-function)
       'my-dabbrev-multiplex-function)
  )



;;拡張子によるモード判別

;; (setq auto-mode-alist (append '(
;; 				("\\.sh$" . fundamental-mode)
;; 				("\\.html$" . html-helper-mode)
;; 				;;		       ("\\.tpl$" . html-helper-mode)
;; 				;;		       ("\\.js$" . js2-mode)
;; 				("\\.txt$" . org-mode)
;; 				("\\.org$" . org-mode)
;; 				("\\.js$" . javascript-mode)
;; 				("\\.rb$" . ruby-mode)
;; 				;;		       ("\\.dot$" . graphviz-dot-mode)

;; 				;;("\\.ctp$" . php-html-helper-mode)
;; 				) auto-mode-alist))

;;;-------txt mode hook ----------
(defun my-text-mode-hook ()
  (set (make-local-variable 'tab-width) 4)
  )
(add-hook 'text-mode-hook 'my-text-mode-hook)


;;;-------org mode hook ----------

(when (require 'org-mode nil t)
  (setq auto-mode-alist
	(append
	 '(("\\.txt$" . org-mode)
	   ("\\.org$" . org-mode))
	 auto-mode-alist))

  (defun my-org-mode-hook ()
    (set (make-local-variable 'tab-width) 4)
    )
  (add-hook 'org-mode-hook 'my-org-mode-hook)

  )

;;;-------lisp mode hook ----------
(when (require 'gemini nil t)
  (defun my-lisp-mode-hook ()
    (make-local-variable 'gemini)
    (gemini t)
    (make-local-variable 'gemini-exclusion-list-in-completion)
    (setq gemini-exclusion-list-in-completion '("\'" "{"))
    ;;(setq gemini-invalid-charactor-list '("\'"))
    )
  (add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
  )

;;;-------emacs lisp mode hook ----------
(when (require 'gemini nil t)
  (defun my-emacs-lisp-mode-hook ()
    (make-local-variable 'gemini)
    (gemini t)
    (make-local-variable 'gemini-exclusion-list-in-completion)
    (setq gemini-exclusion-list-in-completion '("\'" "{"))
    ;;(setq gemini-invalid-charactor-list '("\'" "<" "{"))
    (my-dabbrev-setting-function '(emacs-lisp-mode))
    (define-key emacs-lisp-mode-map [tab] 'indent-for-tab-command)

    )
  (add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)
  )


;;;------------------c-mode-------------------


;;;c-mode時のインデント設定
(defun my-c-mode-hook ()
  (c-set-style "linux")
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (when (require 'gemini nil t)
    (make-local-variable 'gemini)
    ;; 	     ;; flyspell-prog-mode をオンにする
    ;; 	     ;;(flyspell-prog-mode)
    (gemini t)))
(add-hook 'c-mode-hook 'my-c-mode-hook)


;;;------------------c++-mode-------------------

(defun my-c++-mode-hook ()
  (when (require 'gemini nil t)
    (make-local-variable 'gemini)
    (gemini t)
    )
  (c-set-style "gnu")
  (setq c-basic-offset 4)
  (setq tab-width c-basic-offset)
  (setq indent-tabs-mode t)
  (gtags-mode 1)
  ;;(gtags-make-complete-list)
  )

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;;;------------------php-mode hook-------------------



;;;php-modeのインデント設定
;; (defun my-php-mode-hook ()
;;   (require 'php-completion)
;;   (define-key php-mode-map  (kbd "C-M-/") 'phpcmp-complete)
;;   (when (require 'auto-complete nil t)
;; 	(make-variable-buffer-local 'ac-sources)
;; 	(add-to-list 'ac-sources 'ac-source-php-completion)
;; 	(auto-complete-mode t))

;;   (my-dabbrev-setting-function '(php-mode))
;;   (make-local-variable 'gemini)
;;   (gemini t))

;; (add-hook 'php-mode-hook 'my-php-mode-hook)


;;;------------------ruby-mode settings-------------------

;;require
;; (add-to-list 'load-path "~/.emacs.d/ruby")

(require 'ruby-mode)

(add-to-list 'auto-mode-alist '("\\.erb$" . html-helper-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;;hook
(defun my-ruby-mode-hook ()
  (setq tab-width 3)
  (setq indent-tabs-mode 't)
  (setq ruby-indent-level tab-width)
  (make-local-variable 'hs-minor-mode)
  (hs-minor-mode 1)

  ;; 括弧補完の追加入力を無効化
  ;; (set (make-local-variable 'gemini-brace-additional-function)
  ;; '(lambda (arg) nil))
  ;; (set (make-local-variable 'gemini-bracket-additional-function)
  ;; '(lambda (arg) nil))

  ;;(set (make-local-variable 'gemini-brace-additional-function)
  ;;     '(lambda (arg)
  ;; (make-local-variable 'gemini-brace-additional-function)
  ;; (defun gemini-brace-additional-function (arg)
  ;;   (insert " ")
  ;;   (insert arg)
  ;;   (backward-char)
  ;;   t)
  ;; (make-local-variable 'gemini-bracket-additional-function)
  ;; (defun gemini-bracket-additional-function (arg)
  ;;   (insert " ")
  ;;   (insert " ")
  ;;   (insert arg)
  ;;   (backward-char 2)
  ;;   t)
  (my-dabbrev-setting-function '(ruby-mode))
  (make-local-variable 'gemini)
  (gemini t)
  (when (require 'ruby-electric nil t)
    (make-local-variable 'ruby-electric-mode)
    (ruby-electric-mode t))
  ;;ruby-block-mode
  (when (require 'ruby-block nil t)
    (make-local-variable 'ruby-block-mode)
    (ruby-block-mode t)
    )

  (define-key ruby-mode-map "\C-c\{"
    '(lambda () (interactive)
       ;; gemini-brace-additional-function を一時的に置き換える
       (let ((old-brace-function))
	 (fset 'old-brace-function (symbol-function 'gemini-brace-additional-function))
	 (defun gemini-brace-additional-function (arg) nil)
	 (gemini-completion-parenthesis "{")
	 (fset 'gemini-brace-additional-function (symbol-function 'old-brace-function))
	 )))
  
  )
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)



;;ruby-mode のインデント設定 ついで
;;(setq ruby-indent-level 2)
;;(setq ruby-indent-tabs-mode nil)

;;hide条件設定
(let ((ruby-mode-hs-info
       '( ruby-mode
	  "class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do"
	  "end"
	  "#"
	  ruby-move-to-block
	  nil)))
  (if (not (member ruby-mode-hs-info hs-special-modes-alist))
      (setq hs-special-modes-alist
	    (cons ruby-mode-hs-info hs-special-modes-alist))))

;;hide状態のコードをisearchで検索しない
(setq search-invisible nil)


(when (require 'ruby-electric nil t)

  ;;electric-modeのキーマップを上書き
  (defun ruby-electric-setup-keymap()
    (define-key ruby-mode-map " " 'ruby-electric-space)
    (define-key ruby-mode-map "\(" 'gemini-completion-parenthesis)
    (define-key ruby-mode-map "\[" 'gemini-completion-parenthesis)
    (define-key ruby-mode-map "\{" 'gemini-completion-parenthesis)
    (define-key ruby-mode-map "'" 'gemini-completion-quote)
    (define-key ruby-mode-map "\"" 'gemini-completion-quote)
    ;;  (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
    (define-key ruby-mode-map "\C-m" 'reindent-then-newline-and-indent)
    (define-key ruby-mode-map "\C-j" 'newline)

    )
  )

;;括弧補完を無効化 キーマップが設定されるので不採用
;;(setq ruby-electric-expand-delimiters-list nil)

;;ido-mode の設定
;; (when (require 'ido nil t)
;;   (ido-mode t))


;; rinari の設定
(add-to-list 'load-path "~/.emacs.d/rinari")
(when (require 'rinari nil t)
  
  )

;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/rhtml")
(when (require 'rhtml-mode nil t)
  (add-hook 'rhtml-mode-hook
	    (lambda () (rinari-launch))))

;;;------------------scala-mode settings-------------------


;; (add-to-list 'load-path "~/.emacs.d/scala-mode")
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp")

(when (require 'scala-mode-auto nil t)
  (setq scala-interpreter "/usr/bin/scala -Xnojline")
  (add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))

  (defun my-scala-mode-hook ()
    (make-local-variable 'gemini)
    (gemini t)
    (auto-complete-mode t)

    ;;(setq 'gemini-brace-additional-function nil)
    ;; (set (make-local-variable 'gemini-brace-additional-function)
    ;; 	 '(lambda (arg) nil))

    (make-local-variable 'gemini-brace-additional-function)

    (define-key scala-mode-map "\C-cs" 'scala-run-scala)
    (define-key scala-mode-map "\C-c\C-e" 'scala-eval-definition)
    (define-key scala-mode-map "\C-ce" 'scala-eval-buffer)
    (define-key scala-mode-map "\C-j" 'scala-newline)
    (define-key scala-mode-map "\C-m" '(lambda () (interactive) (scala-newline)(scala-indent-line)))

    ;; 改行なし補完 scala のimport での{}表記に対応するため
    (define-key scala-mode-map "\C-c\{"
      '(lambda () (interactive)
	 ;; gemini-brace-additional-function を一時的に置き換える
	 (let ((old-brace-function))
	   (fset 'old-brace-function (symbol-function 'gemini-brace-additional-function))
	   (defun gemini-brace-additional-function (arg) nil)
	   (gemini-completion-parenthesis "{")
	   (fset 'gemini-brace-additional-function (symbol-function 'old-brace-function))
	   )))
    
    )

  (add-hook 'scala-mode-hook 'my-scala-mode-hook)
  )

(when (require 'ensime nil t)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))
;; (add-hook 'scala-mode-hook
;;  (lambda ()
;;     (define-key global-map "\C-cs" 'scala-run-scala)
;;     (define-key global-map "\C-c\C-e" 'scala-eval-definition)
;;     (define-key global-map "\C-ce" 'scala-eval-buffer)))

;;;------------------html-mode settings-------------------

;;html-helper-mode フック

(when (require 'html-helper-mode nil t)


  (defun my-html-helper-mode-hook ()
    (make-local-variable 'gemini)
    (gemini t)
    (setq gemini-use-parenthesis-balance nil)
    (define-key html-helper-mode-map "<" 'gemini-completion-parenthesis)
    (set (make-local-variable 'gemini-brace-additional-function)
	 '(lambda (arg) nil))
    (setq html-helper-build-new-buffer nil)
    (my-dabbrev-setting-function '(html-helper-mode))

    )
  (add-hook 'html-helper-mode-hook 'my-html-helper-mode-hook)


;;;html-helper-mode へのdiv追加

  ;;タグの追加
  (html-helper-add-type-to-alist
   '(div . (html-helper-div-map "\C-c\C-d" html-helper-div-menu "Insert div tag")))
  (html-helper-install-type 'div)

  ;;各種テンプレ追加
  (html-helper-add-tag '(div "d" "<div>" "div" ("<div>\n" (r "Text:") "\n</div>")))
  (html-helper-add-tag '(div "c" "<div class" "divcl" ("<div class=\"" (r "Text:") "\">\n\n</div>")))
  (html-helper-add-tag '(div "i" "<div id" "divid" ("<div id=\"" (r "Text:") "\">\n\n</div>")))
  (html-helper-add-tag '(div "s" "<div style" "divst" ("<div style=\"" (r "Text:") "\">\n\n</div>")))


  (html-helper-add-type-to-alist
   '(ownm . (html-helper-ownm-map "\C-c\C-c" html-helper-ownm-menu "Insert own mading tag")))
  (html-helper-install-type 'ownm)
  (html-helper-add-tag '(ownm "p" "<?php" "php" ("<?php " (r "Text:") " ?>")))
  (html-helper-add-tag '(ownm "%" "<%" "emb" ("<% " (r "Text:") " %>")))
  (html-helper-add-tag '(ownm "=" "<%=" "emb=" ("<%= " (r "Text:") " %>")))

  )



;;;------------------js-mode fook-------------------
;;;js2-modeのロード
(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(setq auto-mode-alist '("\\.js$" . js2-mode) auto-mode-alist))

;;;javascript-modeのロード
(autoload 'javascript-mode "javascript" nil t)


;;js2-mode のインデント固定用 js2-modeはc-modeのものを利用
(setq-default c-basic-offset 4)

;;「#！」がファイルの先頭にあるファイルをスクリプトとして扱う

(setq interpreter-mode-alist
      (append '(;;("jperl" . perl-mode)
                ("sh" . fundamental-mode)
                ("bash" . fundamental-mode))
              interpreter-mode-alist))



;;テンプレート設定
(setq auto-insert-directory "~/.emacs.d/templates/")
(auto-insert-mode t)
(setq auto-insert-alist
      (append '(
                ("\\.sh$" . "template.sh")
                ("\\.py$" . "template.py")
                ("\\.cpp$" . "template.cpp")
		("\\.h$" . "template.h")
		;;("\\.html$" . "template.html")
		("\\.org$" . "template.org")
		("\\.txt$" . "template.org")
		("\\.dot$" . "template.dot")

		;;(Shell-script-mode . "template.sh")
		;;(fundamental-mode . "template.sh")
                ) auto-insert-alist))



;;;------------------mmm-mode setting-------------------

;;; mmm-modeの設定
(when (require 'mmm-mode nil t)
  (setq mmm-global-mode 'maybe)
  (setq mmm-submode-decoration-level 2)
  (set-face-background 'mmm-default-submode-face "gray21")



  ;; (mmm-add-classes
  ;;  '((html-php
  ;;     :submode php-mode
  ;; 	:front "<\\?\\(php\\)?"
  ;; 	:back "\\?>")))

;;; mmm-modeのサブモード切替設定
					;(mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
  ;; (mmm-add-mode-ext-class nil "\\.ctp?\\'" 'html-php)

  ;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . html-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.ctp?\\'" . php-html-helper-mode))


;;;mmmでのphpインデント対応
  ;; (defun save-mmm-c-locals ()
  ;;   (with-temp-buffer
  ;; 	(php-mode)
  ;; 	(dolist (v (buffer-local-variables))
  ;; 	  (when (string-match "\\`c-" (symbol-name (car v)))
  ;; 		(add-to-list 'mmm-save-local-variables `(,(car v) nil
  ;; 							 ,mmm-c-derived-modes))))))
  ;; (save-mmm-c-locals)
  )
;;;ここまで


;;;------------------shell-mode setting-------------------

(add-to-list 'auto-mode-alist '("\\.sh$" . shell-script-mode))

;;;なんかshellのモード？
;; (require 'shell-command)
;; (shell-command-completion-mode)



;;;20070127 smart-compile.el の設定

(when (require 'smart-compile) nil t


      ;;スマートコンパイル用キー割り当て
      ;;そのうち各モードのフックで、キーバインドを設定するよう変更予定
      ;;とりあえずグローバルは外した
      ;;(global-set-key "\C-c\C-c" 'smart-compile)

      (add-hook 'c-mode-common-hook
		(lambda ()(local-set-key "\C-c\C-c" 'smart-compile)))

      (add-hook 'sh-mode-hook
		(lambda ()(local-set-key "\C-c\C-c" 'smart-compile)))

      (define-key menu-bar-tools-menu [compile] '("Compile..." . smart-compile))



      ;;コンパイルオプション指定
      (defvar smart-compile-alist
	'(
	  ("\\.c\\'"          . "gcc -g -W -Wall -O2 %f -lm -o %n")
	  ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 -g -W -Wall  %f -lm -o %n")
	  ("\\.java\\'"       . "javac %f")
	  ("\\.f90\\'"        . "f90 %f -o %n")
	  ("\\.[Ff]\\'"       . "f77 %f -o %n")
	  ("\\.tex\\'"        . (tex-file))
	  ("\\.pl\\'"         . "perl -cw %f")
	  ("\\.rb\\'"         . "ruby")
	  (emacs-lisp-mode    . (emacs-lisp-byte-compile))
	  ) "...")
      )

;;;シェルモードのファイルに、自動的に実行権限を付加
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
	(let ((name (buffer-file-name)))
	  (or (equal ?. (string-to-char (file-name-nondirectory name)))
	      (let ((mode (file-modes name)))
		(set-file-modes name (logior mode (logand (/ mode 4) 73)))
		(message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)


;; シェルモードでのパスワード入力を表示しない
(add-hook 'comint-output-filter-functions ; 2004-07-27 訂正
	  'comint-watch-for-password-prompt)

;; シェルモードでの入力待を変更している時
(setq shell-command-regexp "[^;&|>]+")



;;シェルモードのエスケープシーケンスを処理
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;;; shell-modeで上下でヒストリ補完
(add-hook 'shell-mode-hook
	  (function (lambda ()
		      (set (make-local-variable 'scroll-margin) 0)

		      (define-key shell-mode-map "\C-p" 'comint-previous-input)
		      (define-key shell-mode-map "\C-n" 'comint-next-input)
		      (define-key shell-mode-map [up] 'comint-previous-input)
		      (define-key shell-mode-map [down] 'comint-next-input))))


;;cssモードのインデント
;;	(setq cssm-indent-function #'cssm-c-style-indenter)


;;; タグファイル名の設定
;;; tag-file-nameとtags-table-listの両方を指定してはいけない
					;(setq tags-file-name "~/devel/cpp/TAGS")
(setq tags-file-name "./TAGS")
;;または
;;(setq tags-table-list
;; '("~/devel/cpp/" "~/devel/python")

;;; etags　タグファイル自動作成
(defun etags-find (dir pattern)
  " find DIR -name 'PATTERN' |etags -"
  (interactive
   "DFind-name (directory): \nsFind-name (filename wildcard): ")
  (shell-command
   ;;   (concat "find " dir " -type f -name \"" pattern "\" |etags.emacs -")))
   (concat "find " dir " -type f -name \"" pattern "\" |etags - --members")))

;;;gtags
(autoload 'gtags-mode "gtags" "" t)
;; (setq gtags-mode-hook
;;  '(lambda ()
;; 	 (local-set-key "\M-t" 'gtags-find-tag)
;; 	 (local-set-key "\M-r" 'gtags-find-rtag)
;; 	 (local-set-key "\M-s" 'gtags-find-symbol)
;; 	 (local-set-key "\C-t" 'gtags-pop-stack)
;;   ))

;; (add-hook 'c-mode-common-hook
;;           '(lambda()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)
;;              ))
;;gtagsのSELECTバッファを移動対象から外す
(setq iswitchb-buffer-ignore '("^ " "^TAGS" "\\*GTAGS SELECT" "\\*Ibuffer\\*"))

(provide 'my-major-mode-conf)
