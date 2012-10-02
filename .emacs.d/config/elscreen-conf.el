;;------------------;;
;;    elscreen      ;;
;;------------------;;
(load "elscreen" "ElScreen" t)
(setq elscreen-prefix-key "\C-z");elscreen読み込み前に設定する場合
;;(elscreen-set-prefix-key "\C-z");elscreen読み込み後に設定する場合
;;タブ幅変更
(setq elscreen-display-tab 14)

;;(require 'elscreen-w3m)
;;(require 'elscreen-speedbar)
(require 'elscreen-dired)
;;(require 'elscreen-dnd)

;;buffer-list 分割
(require 'elscreen-buffer-list)

;; elscreen keybind
(global-set-key [(C tab)] 'elscreen-next)
(global-set-key [(C S tab)] 'elscreen-previous)

