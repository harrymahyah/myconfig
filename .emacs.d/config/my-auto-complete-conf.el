;;------------------;;
;; 　　 略語展開 　 ;;
;;------------------;;

;;auto-complete.el
;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;;(ac-config-default)

;; (add-to-list 'load-path "~/.emacs.d/auto-complete")


(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (ac-config-default)

  ;;同じメジャーモードの他ファイルから補完候補を得る
  (push 'ac-source-words-in-same-mode-buffers ac-sources)
  ;;  (global-auto-complete-mode t)
  ;; (set-face-background 'ac-selection-face "steelblue")
  ;; (define-key ac-complete-mode-map "\t" 'ac-expand)
  ;; (define-key ac-complete-mode-map "\r" 'ac-complete)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (define-key ac-mode-map [(M \?)] 'auto-complete);;binding as "Alt-Shift-/"

  ;; (setq ac-auto-start t)
  (add-to-list 'ac-modes 'org-mode)

  ;;pos-tip
  (when (require 'pos-tip nil t)
    (setq ac-quick-help-prefer-x t)
    )

  ;; auto-completeの補完元にdabbrev
  ;; (when (require 'ac-dabbrev nil t)
  ;;   (setq ac-sources
  ;; 		(list ac-source-dabbrev)))

  (require 'auto-complete-clang)
  (defun my-ac-cc-mode-setup ()
    ;; 読み込むプリコンパイル済みヘッダ
    ;; (setq ac-clang-prefix-header "stdafx.pch")
    ;; 補完を自動で開始しない
    (setq ac-auto-start nil)
    (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
    (setq ac-sources (append '(ac-source-clang
			       ac-source-yasnippet
			       ac-source-gtags)
			     ac-sources)))
  (defun my-ac-config ()
    (global-set-key "\M-/" 'ac-start)
    ;; C-n/C-p で候補を選択
    (define-key ac-complete-mode-map "\C-n" 'ac-next)
    (define-key ac-complete-mode-map "\C-p" 'ac-previous)
    (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
    (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
    (add-hook 'ruby-mode-hook 'ac-css-mode-setup)
    (add-hook 'auto-complete-mode-hook 'ac-common-setup)
    (global-auto-complete-mode t))
  
  (my-ac-config)
  )

