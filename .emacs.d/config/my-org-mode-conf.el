
;;;----------------orgモード設定--------------
(require 'org-install)
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)



;; org-default-notes-fileのディレクトリ
(setq org-directory "~/work/doc/org/")
;; (setq org-directory "~/doc/org/")

;; org-default-notes-fileのファイル名
(setq org-default-notes-file "notes.org")

;;org-modeでfontlockを有効に
(add-hook 'org-mode-hook 'turn-on-font-lock)

;;truncateを無効に
(setq org-startup-truncated nil)

;; TODO State list
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "SOMEDAY(s)" "|" "DONE(d)"  )))
;; done with timestamp
(setq org-log-done 'time)

;; アジェンダ表示の対象ファイル
(setq org-agenda-files (list org-directory))

;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)

;; 標準の祝日を利用しない
(setq calendar-holidays nil)


;; enable org-remember
(org-remember-insinuate)

;; org-remember's template
(setq org-remember-templates
      '(("Note" ?n "* %?\n  %i\n  %a" nil "Tasks")
	("Todo" ?t "* TODO %?\n  %i\n  %a" nil "Tasks")))


;;html出力時に、svg を画像として扱うように
(when (require 'org-html nil t)
  (add-to-list 'org-export-html-inline-image-extensions "svg")
  )

;; publish 設定

(when (require 'org-publish nil t)

  (setq my-org-export-dir-external "~/Public/")
  ;; (setq my-org-export-dir-external "D:/xampplite/htdocs/dairyr")

  (setq org-publish-project-alist
	'(
	  ;; ("org-notes"
	  ;;  :base-directory "~/org/"
	  ;;  :base-extension "org"
	  ;;  :publishing-directory "~/public_html/"
	  ;;  :recursive t
	  ;;  :publishing-function org-publish-org-to-html
	  ;;  :headline-levels 4             ; Just the default for this project.
	  ;;  :auto-preamble t
	  ;;  )

	  ;; ("org-static"
	  ;;  :base-directory "~/org/"
	  ;;  :base-extension "css\\|js\\|png\\|jpg\\|gif\\|png\\|pdf\\|mp3\\|ogg\\|swf"
	  ;;  :publishing-directory "~/public_html/"
	  ;;  :recursive nil
	  ;;  :publishing-function org-publish-attachment
	  ;;  )

	  ;;("org" :components ("org-notes" "org-static"))
	  ("org-notes-current"
	   :base-directory "./"
	   :base-extension "org"
	   :publishing-directory "./html"
	   :recursive nil
	   :publishing-function org-publish-org-to-html
	   :headline-levels 4             ; Just the default for this project.
	   :auto-preamble t

	   )

	  ("org-image-current"
	   :base-directory "./image"
	   :base-extension "png\\|jpg\\|gif\\|pdf"
	   :publishing-directory "./html/image"
	   :recursive nil
	   :publishing-function org-publish-attachment
	   )

	  ("org-css-current"
	   :base-directory "./css"
	   :base-extension "css"
	   :publishing-directory "./html/css"
	   :recursive nil
	   :publishing-function org-publish-attachment
	   )

	  ("org-notes-external"
	   :base-directory "./"
	   :base-extension "org"
	   :publishing-directory "./";; my-org-export-dir-external
	   ;;:publishing-directory "D:/xampplite/htdocs/document/";; my-org-export-dir-external
	   ;; :publishing-directory my-org-export-dir-external
	   :recursive nil
	   :publishing-function org-publish-org-to-html
	   :headline-levels 4             ; Just the default for this project.
	   :auto-preamble t

	   )

	  ("org-image-external"
	   :base-directory "./image"
	   :base-extension "png\\|jpg\\|gif\\|pdf"
	   :publishing-directory "./image" ;;(concat my-org-export-dir-external "/image")
	   :recursive nil
	   :publishing-function org-publish-attachment
	   )

	  ("org-css-external"
	   :base-directory "./css"
	   :base-extension "css"
	   :publishing-directory "./css";;(concat my-org-export-dir-external "/css")
	   :recursive nil
	   :publishing-function org-publish-attachment
	   )

	  ;;("org-current " :components ("org-notes-current" "org-static-current"))
	  ;;("org-current" :components ("org-notes-current" "org-image-current" "org-css-current"))
	  ("org-external" :components ("org-notes-external" "org-image-external" "org-css-external"))

	  ))
  ;; キーバインド @ org-mode-map
  ;;(define-key org-mode-map "\C-cp" 'org-publish-project)
  (define-key org-mode-map "\C-cp"
    `(lambda ()
       ;;(org-publish-project "org-current")
       (interactive)
       (org-publish-project (assoc "org-current" org-publish-project-alist ))
       ))

  (define-key org-mode-map "\C-ce"
    `(lambda ()
       ;;(org-publish-project "org-current")
       (interactive)

       ;; (let ((ext-list  (assoc "org-notes-external" org-publish-project-alist ))
       ;; 		 (target-pos)
       ;; 		 (current-export-dir)
       ;; 		 )
       ;; 	 (setq target-pos (1+ (- (length ext-list) (length (memq :publishing-directory ext-list)))))
       ;; 	 (setq current-export-dir (nth  target-pos ext-list))
       
       ;; 	 ;;(nthcdr
       ;; 	  (concat current-export-dir 
       ;; 			 (substring default-directory (string-match "/[^/]+/$" default-directory ) (1- (length default-directory))))
       ;; 	 ;; current-export-dir
       ;; 	   (cdr (nthcdr target-pos ext-list))
       ;; 	   (nthcdr (- (length ext-list) target-pos) (nreverse ext-list))
       
       ;; 	 )
       (org-publish-project (assoc "org-external" org-publish-project-alist ))
       
       ))
  ;;キーバインド解除
  (define-key org-mode-map [(C ?,)] nil)
  ;;(define-key org-mode-map [(C tab)] 'elscreen-next)
  (define-key org-mode-map [(C tab)] 'nil)


  ;; テンプレート追加
  (when (require 'tempo nil t)
    
    ;;下矢印
    (define-key org-mode-map "\C-cn"
      (tempo-define-template "next-flow" '("{{{blue-indent2(↓)}}}" )))

    ;; quote マクロ
    (define-key org-mode-map "\C-cq"
      (tempo-define-template "quote" '("#+BEGIN_QUOTE\n" p "\n#+END_QUOTE")))

    ;; マクロ呼び出し？
    (define-key org-mode-map "\C-cm"
      (tempo-define-template "macro" '("{{{" p "(" p " )}}}" )))

    ;;br
    (define-key org-mode-map "\C-cb"
      (tempo-define-template "br" '("@<br>" p )))

    ;;div
    (define-key org-mode-map "\C-cd"
      (tempo-define-template "div" '("@<div class=\"" p "\"> " p " @</div>")))

    ;; tempo の書き込みポイント移動
    (define-key org-mode-map "\C-cj" 'tempo-forward-mark)
    (define-key org-mode-map "\C-ch" 'tempo-backward-mark)

    

    )
  )


(provide 'my-org-mode-conf)
