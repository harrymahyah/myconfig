;;------------------;;
;;    elscreen      ;;
;;------------------;;
(load "elscreen" "ElScreen" t)
(setq elscreen-prefix-key "\C-z");elscreen�ɤ߹����������ꤹ����
;;(elscreen-set-prefix-key "\C-z");elscreen�ɤ߹��߸�����ꤹ����
;;�������ѹ�
(setq elscreen-display-tab 14)

;;(require 'elscreen-w3m)
;;(require 'elscreen-speedbar)
(require 'elscreen-dired)
;;(require 'elscreen-dnd)

;;buffer-list ʬ��
(require 'elscreen-buffer-list)

;; elscreen keybind
(global-set-key [(C tab)] 'elscreen-next)
(global-set-key [(C S tab)] 'elscreen-previous)

