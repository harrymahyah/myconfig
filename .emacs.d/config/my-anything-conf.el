;;anything
(require 'anything-config)

(defvar my-anything-active-p nil)
;;(setq my-anything-active-p nil)

;; anything 中は、view-mode の挙動を変える
(add-hook 'anything-after-persistent-action-hook
          (lambda ()
	    ;;(make)
	    (setq my-anything-active-p nil)
	    ;; (local-set-key "\C-c\C-c" 'smart-compile)
	    ))

(add-hook 'anything-after-action-hook
          (lambda ()
	    ;;(make)
	    (setq my-anything-active-p nil)
	    ;; (local-set-key "\C-c\C-c" 'smart-compile)
	    ))

(add-hook 'anything-before-initialize-hook
          (lambda ()
	    ;;(make)
	    (setq my-anything-active-p t)
	    ;; (local-set-key "\C-c\C-c" 'smart-compile)
	    ))

(define-key ctl-x-map (kbd "b") 'anything)
;; (define-key ctl-x-map (kbd "b") '(lambda ()
;; 								   (interactive)
;; 								   (setq my-anything-active-p t)
;; 								   anything))
(define-key anything-map (kbd "C-M-n") 'anything-next-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-source)
(define-key anything-map (kbd "C-q") 'anything-quit)
(define-key anything-map (kbd "C-j") 'anything-exit-minibuffer)

;;anything with emacs-command
(add-to-list 'anything-sources
	     ;; 'anything-c-source-emacs-commands
	     ;;			 'anything-c-source-buffers+
	     'anything-c-source-elscreen
	     'anything-c-source-bookmarks
	     ;; 'anything-c-source-google-suggest
	     )

