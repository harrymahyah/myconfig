
;;view-mode setting

(when (require 'view nil t)

  (setq view-read-only t)
  (defvar pager-keybind
    ;; (setq pager-keybind
    `(
      ;;("m" . View-scroll-half-page-forward)
      ;;("n" . View-scroll-half-page-forward)

      ;; vi-like
      ("h" . backward-word)
      ("l" . forward-word)
      ("j" . next-window-line)
      ("k" . previous-window-line)

      (";" . gene-word)
      ("b" . scroll-down)
      (" " . scroll-up)
      ;; w3m-like
      ;;("m" . gene-word)
      ("i" . win-delete-current-window-and-squeeze)
      ("w" . forward-word)
      ("e" . backward-word)
      ("(" . point-undo)
      (")" . point-redo)
      ("J" . ,(lambda () (interactive) (scroll-up 1)))
      ("K" . ,(lambda () (interactive) (scroll-down 1)))
      ;; bm-easy
      ("." . bm-toggle)
      ("[" . bm-previous)
      ("]" . bm-next)
      ;; langhelp-like
      ("c" . scroll-other-window-down)
      ("v" . scroll-other-window)
      ))

  (defvar my-anything-viewer-keybind
    `(
      ;; vi-like
      ("h" . anything-previous-source)
      ("l" . anything-next-source)
      ("j" . anything-next-line)
      ("k" . anything-previous-line)
      ("m" . anything-exit-minibuffer)
      ("g" . anything-quit)

      ))


  (defun define-many-keys (keymap key-table &optional includes)
    (let (key cmd)
      (dolist (key-cmd key-table)
	(setq key (car key-cmd)
	      cmd (cdr key-cmd))
	(if (or (not includes) (member key includes))
	    (define-key keymap key cmd))))
    keymap)


  ;; (when (require 'view nil t)
  ;; ;;   (view-mode t)
  ;;   (define-many-keys view-mode-map pager-keybind)
  ;; ;;   (view-mode nil)
  ;;   )


  (defvar my-binding-list '())
  ;; (setq my-binding-list '())

  (add-to-list 'my-binding-list
	       '(my-anything-active-p . my-anything-viewer-keybind))



  (defun view-mode-hook0 ()
    ;; (if my-anything-active-p
    ;; 	  (progn
    ;; 		(define-many-keys view-mode-map my-anything-viewer-keybind)
    ;; 		;;(setq my-anything-active-p nil)
    ;; 		)
    ;;(define-many-keys view-mode-map pager-keybind)
    ;;)
    ;; (hl-line-mode 1)
    (define-key view-mode-map " " 'scroll-up))
  (add-hook 'view-mode-hook 'view-mode-hook0)

  (defadvice anything (before change-anything-viewmap ())
    "change view-mode-map for anything"
    (define-many-keys view-mode-map my-anything-viewer-keybind)
    )
  (ad-activate 'anything)


  (defadvice keyboard-quit (before restore-viewmap ())
    "restore view-mode keymaps"
    (define-many-keys view-mode-map pager-keybind)
    )
  (ad-activate 'keyboard-quit)


  (defadvice abort-recursive-edit (before restore-viewmap ())
    "restore view-mode keymaps"
    (define-many-keys view-mode-map pager-keybind)
    )
  (ad-activate 'abort-recursive-edit)




  ;; (add-hook 'w3m-mode
  ;; 	  (lambda ()
  ;; 	    (require 'context-skk)
  ;; 	    ))


  ;; (defadvice keyboard-quit (after restore-normal-viewer (arg))
  ;;   (define-many-keys view-mode-map )
  ;;   )



  ;; 書キ込ミ不能ナファイルハview-modeデ開クヨウニ
  (defadvice find-file
    (around find-file-switch-to-view-file (file &optional wild) activate)
    (if (and (not (file-writable-p file))
	     (not (file-directory-p file)))
	(view-file file)
      ad-do-it))
  ;; 書キ込ミ不能ナ場合ハview-modeヲ抜ケナイヨウニ
  (defvar view-mode-force-exit nil)
  (defmacro do-not-exit-view-mode-unless-writable-advice (f)
    `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
       (if (and (buffer-file-name)
		(not view-mode-force-exit)
		(not (file-writable-p (buffer-file-name))))
	   (message "File is unwritable, so stay in view-mode.")
	 ad-do-it)))

  (do-not-exit-view-mode-unless-writable-advice view-mode-exit)
  (do-not-exit-view-mode-unless-writable-advice view-mode-disable)


  ;; w3m view mode setting
  (when (require 'w3m-mode nil t)

    (defvar my-w3m-viewer-keybind
      `(

	;; vi-like
	("h" . backward-word)
	("l" . forward-word)
	("j" . next-window-line)
	("k" . previous-window-line)
	("n" . w3m-view-next-page)
	("p" . w3m-view-previous-page)

	))

    (defvar my-w3m-active-p nil)
    (defun my-w3m-mode-hook ()
      (setq my-w3m-active-p t)
      )
    (add-hook 'w3m-mode-hook 'my-w3m-mode-hook)

    (add-to-list 'my-binding-list
		 '(my-w3m-active-p . my-w3m-viewer-keybind))

    (defadvice w3m (before change-web-viewmap ())
      "change view-mode-map for w3m"
      (define-many-keys view-mode-map my-w3m-viewer-keybind)
      )
    (ad-activate 'w3m)
    )

  )

(provide 'my-viewmode-conf)
