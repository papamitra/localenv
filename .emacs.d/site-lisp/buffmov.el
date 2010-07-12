(defvar my-ignore-blst             ; ��ư�κݤ�̵�뤹��Хåե��Υꥹ��
  '("*Help*" "*Compile-Log*" "*Mew completions*" "*Completions*"
    "*Shell Command Output*" "*Apropos*" "*Buffer List*"))
(defvar my-visible-blst nil)       ; ��ư���ϻ��� buffer list ����¸
(defvar my-bslen 15)               ; buffer list ��� buffer name �κ���Ĺ
(defvar my-blist-display-time 2)   ; buffer list ��ɽ������
(defface my-cbface                 ; buffer list ��� current buffer �򼨤� face
  '((t (:foreground "wheat" :underline t))) nil)

(defun my-visible-buffers (blst)
  (if (eq blst nil) '()
    (let ((bufn (buffer-name (car blst))))
      (if (or (= (aref bufn 0) ? ) (member bufn my-ignore-blst))
          ;; �ߥ˥Хåե���̵�뤹��Хåե��ˤϰ�ư���ʤ�
          (my-visible-buffers (cdr blst))
        (cons (car blst) (my-visible-buffers (cdr blst)))))))

(defun my-show-buffer-list (prompt spliter)
  (let* ((len (string-width prompt))
         (str (mapconcat
               (lambda (buf)
                 (let ((bs (copy-sequence (buffer-name buf))))
                   (when (> (string-width bs) my-bslen) ;; �ڤ�ͤ� 
                     (setq bs (concat (substring bs 0 (- my-bslen 2)) "..")))
                   (setq len (+ len (string-width (concat bs spliter))))
                   (when (eq buf (current-buffer)) ;; ���ߤΥХåե��϶�Ĵɽ��
                     (put-text-property 0 (length bs) 'face 'my-cbface bs))
                   (cond ((>= len (frame-width)) ;; frame ����Ŭ������
                          (setq len (+ (string-width (concat prompt bs spliter))))
                          (concat "\n" (make-string (string-width prompt) ? ) bs))
                         (t bs))))
               my-visible-blst spliter)))
    (let (message-log-max)
      (message "%s" (concat prompt str))
      (when (sit-for my-blist-display-time) (message nil)))))

(defun my-operate-buffer (pos)
  (unless (window-minibuffer-p (selected-window));; �ߥ˥Хåե��ʳ���
    (unless (eq last-command 'my-operate-buffer)
      ;; ľ���˥Хåե����ڤ��ؤ��Ƥʤ���ХХåե��ꥹ�Ȥ򹹿�
      (setq my-visible-blst (my-visible-buffers (buffer-list))))
    (let* ((blst (if pos my-visible-blst (reverse my-visible-blst))))
      (switch-to-buffer (or (cadr (memq (current-buffer) blst)) (car blst))))
    (my-show-buffer-list (if pos "[-->] " "[<--] ") (if pos " > "  " < " )))
  (setq this-command 'my-operate-buffer))

(global-set-key [?\C-,] (lambda () (interactive) (my-operate-buffer nil)))
(global-set-key [?\C-.] (lambda () (interactive) (my-operate-buffer t)))
