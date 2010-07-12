;;; -*- Emacs-Lisp -*-
;;; -*- coding: utf-8 -*-

(setq load-path
      (append
       (list
       (expand-file-name "~/.emacs.d/")
       (expand-file-name "~/.emacs.d/site-lisp")
       )
       load-path))

(global-font-lock-mode t)
;(load "term/bobcat")

(load "elscreen" "ElScreen" t)
; C-', C-;でscreenを移動
(global-set-key [?\C-'] 'elscreen-next)
(global-set-key [?\C-;] 'elscreen-previous)
(global-set-key [?\C-t] 'elscreen-clone)
(global-set-key [?\C-q] 'elscreen-kill)

;moccur
(require 'color-moccur)
(require 'moccur-edit)

;(load "term/keyswap")
(global-set-key [backspace] 'backward-delete-char)
(keyboard-translate ?\C-h 'backspace)
(global-set-key [delete] 'delete-char)

; color-mode
(require 'color-theme)

;(load "navi")
;(global-set-key [f11] 	   'call-navi)
;(global-set-key "C-xC-l" 'call-navi)
;(defun call-navi ()
;  (interactive)
;  (navi (buffer-name))
;)

;; hook 用の関数の定義
(defun my-c-mode-common-hook ()
  ;; my-c-stye を有効にする
  ;(c-set-style "my-c-style")

  ;;   ;; 次のスタイルがデフォルトで用意されているので選択してもよい
  ;;   (c-set-style "gnu")
  ;;   (c-set-style "cc-mode")
  ;;   (c-set-style "stroustrup")
  ;;   (c-set-style "ellemtel")
  ;;   ;; 既存のスタイルを変更する場合は次のようにする
  ;;   (c-set-offset 'member-init-intro '++)

  (c-set-style "linux")

  ;; タブ長の設定
  (setq tab-width 4)

  ;; オフセットをタブ長と同じに
  (setq c-basic-offset tab-width)
  
  (setq c-tab-always-indent nil)
  (setq	c-argdecl-indent	     4)
  (setq	c-indent-level		     0)
  (setq	c-continued-statement-offset 4)
  (setq	c-continued-brace-offset    -4)

  (setq	c-brace-offset		     4)
  (setq	c-brace-imaginary-offset     4)
  (setq	c-label-offset		    -4)

  ;; タブでインデントするか？(nilならスペースでインデント)
  (setq indent-tabs-mode t)

  ;; 自動改行(auto-newline)を有効にする (C-c C-a)
  (c-toggle-auto-state t)

  ;; 連続する空白の一括削除(hungry-delete)を有効にする (C-c C-d)
  (c-toggle-hungry-state t)

  ;;   ;; セミコロンで自動改行しない
  (setq c-hanging-semi&comma-criteria nil)

  ;; キーバインドの追加
  ;; ------------------
  ;; C-m        改行＋インデント
  ;; C-c c      コンパイルコマンドの起動
  ;; C-h        空白の一括削除
   (define-key c-mode-base-map "\C-j" 'newline-and-indent)
   (define-key c-mode-base-map "\C-m" 'newline)
   (define-key c-mode-base-map "\C-cc" 'compile)
;  (define-key c-mode-base-map "\C-h" 'c-electric-backspace)

  ;;   ;; コンパイルコマンドの設定
  (setq compile-command "make -k 2>&1" )   ; GNU make
  ;;   (setq compile-command "nmake /NOLOGO /S") ; VC++ の nmake

) ;; my-c-mode-common-hook

;; モードに入るときに呼び出す hook の設定
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

; ---- language-env DON'T MODIFY THIS LINE!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 日本語表示の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (not (boundp 'MULE))
    (if (featurep 'xemacs)
        ; xemacs21 の場合
	(progn
	  (set-language-environment "Japanese")
	  (set-default-buffer-file-coding-system 'euc-jp-unix)
	  (set-keyboard-coding-system 'euc-jp-unix)
	  (if (not window-system) (set-terminal-coding-system 'euc-jp-unix))
        )
        ; emacs20 の場合
        (progn
	  (set-language-environment "Japanese")
	  (set-default-coding-systems 'euc-japan-unix)
	  (set-keyboard-coding-system 'euc-japan-unix)
	  (if (not window-system) (set-terminal-coding-system 'euc-japan-unix))
        )
    )
)
; 日本語 info が文字化けしないように
(auto-compression-mode t)
; xemacs の shell-mode で 日本語 EUC が使えるようにする
(if (featurep 'xemacs)
    (add-hook 'shell-mode-hook (function
       (lambda () (set-buffer-process-coding-system 'euc-japan 'euc-japan))))
)
; 日本語 grep
(if (file-exists-p "/usr/bin/jgrep")
    (setq grep-command "jgrep -n -e ")
)

;(require 'migemo)
(load "migemo")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 漢字変換 (skk) の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(set-input-method "japanese-skk")
;(toggle-input-method nil)
; ---- language-env end DON'T MODIFY THIS LINE!
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(browse-url-netscape-program "netscape")
 '(c-basic-offset (quote set-from-style))
 '(c-strict-syntax-p nil)
 '(navi2ch-list-bbstable-url "http://www.ff.iij4u.or.jp/~ch2/bbsmenu.html")
 '(navi2ch-mona-enable t)
 '(navi2ch-mona-on-message-mode t)
 '(riece-nickname "papamitra")
 '(riece-realname nil)
 '(riece-startup-server-list (quote ("irc.reicha.net")))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;C-xjでSKKが起動しないようにする
;(global-set-key "\C-xj" 'register-to-point)

;; 以下独自設定

;行番号を表示させる
(setq line-number-mode t)

;Meta-gで行移動できるようにする
(global-set-key "\M-g" 'goto-line)

;rubydb用
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;C-. C-,でbuffer移動
(load "buffmov")

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

; for javascript
;(autoload 'javascript-mode "javascript" nil t) (setq auto-mode-alist (cons '("\\.js$" . javascript-mode) auto-mode-alist))

(let ((term (getenv "TERM")))
  (if (not (or (equal term "xterm-color") (equal term "screen") (equal term "linux")))
      (progn
	(load "./site-lisp/my-color-theme.el")
	(my-color-theme))))


;; Gaucheのデフォルトエンコーディングに合わせます。
;; Gaucheのデフォルトエンコーディングがeuc-jpの時はutf-8をeuc-jpに
;; してください。
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
;; goshインタプリタのパスに合わせます。-iは対話モードを意味します。
(setq gosh-program-name "/usr/bin/gosh -i")
;; schemeモードとrun-schemeモードにcmuscheme.elを使用します。
;(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'scheme-mode "gauche-mode" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(autoload 'gauche-mode "gauche-mode" nil t) ;1つ目の引数はM-xのあとにタイプするもの、2つ目のはgauche-modeのファイル名
;; ウィンドウを2つに分け、一方でgoshインタプリタを実行するコマンドを定義します。
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme gosh-program-name))
;; そのコマンドをCtrl-cSで呼び出します。
(define-key global-map
  "\C-cS" 'scheme-other-window)

;; 直前/直後の括弧に対応する括弧を光らせます。
(show-paren-mode)

;; .scmならgauche-modeを起動.
(setq auto-mode-alist
      (append '(("\\.scm$" . gauche-mode)) auto-mode-alist))

;; 以下はインデントの定義です。
(put 'and-let* 'scheme-indent-function 1)
(put 'begin0 'scheme-indent-function 0)
(put 'call-with-client-socket 'scheme-indent-function 1)
(put 'call-with-input-conversion 'scheme-indent-function 1)
(put 'call-with-input-file 'scheme-indent-function 1)
(put 'call-with-input-process 'scheme-indent-function 1)
(put 'call-with-input-string 'scheme-indent-function 1)
(put 'call-with-iterator 'scheme-indent-function 1)
(put 'call-with-output-conversion 'scheme-indent-function 1)
(put 'call-with-output-file 'scheme-indent-function 1)
(put 'call-with-output-string 'scheme-indent-function 0)
(put 'call-with-temporary-file 'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 1)
(put 'dolist 'scheme-indent-function 1)
(put 'dotimes 'scheme-indent-function 1)
(put 'if-match 'scheme-indent-function 2)
(put 'let*-values 'scheme-indent-function 1)
(put 'let-args 'scheme-indent-function 2)
(put 'let-keywords* 'scheme-indent-function 2)
(put 'let-match 'scheme-indent-function 2)
(put 'let-optionals* 'scheme-indent-function 2)
(put 'let-syntax 'scheme-indent-function 1)
(put 'let-values 'scheme-indent-function 1)
(put 'let/cc 'scheme-indent-function 1)
(put 'let1 'scheme-indent-function 2)
(put 'letrec-syntax 'scheme-indent-function 1)
(put 'make 'scheme-indent-function 1)
(put 'multiple-value-bind 'scheme-indent-function 2)
(put 'match 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'parse-options 'scheme-indent-function 1)
(put 'receive 'scheme-indent-function 2)
(put 'rxmatch-case 'scheme-indent-function 1)
(put 'rxmatch-cond 'scheme-indent-function 0)
(put 'rxmatch-if  'scheme-indent-function 2)
(put 'rxmatch-let 'scheme-indent-function 2)
(put 'syntax-rules 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'until 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'while 'scheme-indent-function 1)
(put 'with-builder 'scheme-indent-function 1)
(put 'with-error-handler 'scheme-indent-function 0)
(put 'with-error-to-port 'scheme-indent-function 1)
(put 'with-input-conversion 'scheme-indent-function 1)
(put 'with-input-from-port 'scheme-indent-function 1)
(put 'with-input-from-process 'scheme-indent-function 1)
(put 'with-input-from-string 'scheme-indent-function 1)
(put 'with-iterator 'scheme-indent-function 1)
(put 'with-module 'scheme-indent-function 1)
(put 'with-output-conversion 'scheme-indent-function 1)
(put 'with-output-to-port 'scheme-indent-function 1)
(put 'with-output-to-process 'scheme-indent-function 1)
(put 'with-output-to-string 'scheme-indent-function 1)
(put 'with-port-locking 'scheme-indent-function 1)
(put 'with-string-io 'scheme-indent-function 1)
(put 'with-time-counter 'scheme-indent-function 1)
(put 'with-signal-handlers 'scheme-indent-function 1)
(put 'with-locking-mutex 'scheme-indent-function 1)
(put 'guard 'scheme-indent-function 1)

;; for kahua
(require 'kahua)
(setq auto-mode-alist
      (append '(("\\.kahua$" . kahua-mode)) auto-mode-alist))


;; for slime
;(require 'slime)
;;(require 'hyperspec) ; これは付け加えなくても良い
;(add-hook 'lisp-mode-hook (lambda ()
;                            (slime-mode t)))
;(setq inferior-lisp-program "/usr/bin/sbcl" ;sbclのインストールしたパス名にする。
;        slime-net-coding-system 'utf-8-unix)
;(slime-setup '(slime-fuzzy slime-banner slime-asdf slime-autodoc))

;; for ropemacs
(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil)
  )
(global-set-key "\C-xpl" 'load-ropemacs)


;; C-x bで存在しないバッファを指定して新規バッファを開いたときにはデフォルトでlisp-interaction-modeが起動する。
(setq default-major-mode 'lisp-interaction-mode)

; 行番号をつける
;(require 'linum)
;(global-linum-mode)

;;;;;Nxhtml-mode
;;;;;(load "nxhtml/autostart.el")

;; Conditional load of nxhtml because its really heavy, but really good.
(setq *nxhtml-autostart-file* (expand-file-name "~/.emacs.d/site-lisp/nxhtml/autostart.el"))
(defun load-nxhtml-if-required ()
  (if (and (string-match ".+\\.\\(php\\|html\\)$" (buffer-file-name))
	   (not (featurep 'nxhtml-autostart)))
      (progn 
	(load *nxhtml-autostart-file*)
	(nxhtml-mumamo-mode) ;; mumamo loads nxhtml-mode et al
	(define-key nxhtml-mode-map "\M-\t" 'nxml-complete))))
(add-hook 'find-file-hook 'load-nxhtml-if-required)

;; PCのようなregin選択を可能に
(pc-selection-mode 1)

;; kill-ringの履歴
;; n,pで選択. iで貼り付け
(load "browse-yank.el")
(global-set-key "\M-y" 'browse-yank)
(global-set-key [(C S c)] 'browse-yank)

;; shift-tabでwindowを移動する
(global-set-key [backtab] 'other-window)

;; for go
(add-to-list 'load-path "~/go/misc/emacs" t)
(require 'go-mode-load)
(add-hook 'go-mode-hook
          '(lambda()
             (setq tab-width 2)))

;; clojure-mode
(add-to-list 'load-path "~/opt/clojure-mode")
(require 'clojure-mode)

;; swank-clojure
(add-to-list 'load-path "~/opt/swank-clojure/src/emacs")

(setq swank-clojure-jar-path "~/opt/clojure/clojure.jar"
      swank-clojure-extra-classpaths (append (list
					      "~/opt/swank-clojure/src/main/clojure"
					      "~/.clojure/clojure-contrib.jar"
					      "~/src/clojure"
					      "~/src/clojure/classes"
					      "/usr/share/java")
					     (directory-files "/usr/share/java" t "\.jar$"))
      swank-clojure-extra-vm-args (list "-Djava.net.preferIPv4Stack=true"))

(require 'swank-clojure-autoload)

;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(add-to-list 'load-path "~/opt/slime")
(require 'slime)
(slime-setup)

(defmacro defslime-exec (name lisp coding)
  `(defun ,name ()
     (interactive)
     (slime ,lisp ,coding)))

;(defslime-exec slime-run-sbcl 'sbcl 'utf-8-unix)
;(defslime-exec slime-run-clojure 'clojure 'utf-8-unix)
;(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

;; for iswitch
(iswitchb-mode 1)

 	

(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map [?\C-'] 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map [?\C-;] 'iswitchb-prev-match)
  )

(defun iswitchb-possible-new-buffer (buf)
  "Possibly create and visit a new buffer called BUF."
  (interactive)
  (message (format
            "No buffer matching `%s', "
            buf))
  (sit-for 1)
  (call-interactively 'find-file buf))

(defun iswitchb-buffer (arg)
  "Switch to another buffer.
The buffer name is selected interactively by typing a substring.  The
buffer is displayed according to `iswitchb-default-method' -- the
default is to show it in the same window, unless it is already visible
in another frame.
For details of keybindings, do `\\[describe-function] iswitchb'."
  (interactive "P")
  (if arg
      (call-interactively 'switch-to-buffer)
    (setq iswitchb-method iswitchb-default-method)
    (iswitchb)))

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

; for scala
(add-to-list 'load-path "/home/insight/opt/scala/misc/scala-tool-support/emacs")
(require 'scala-mode-auto)
(setq scala-interpreter "~/opt/scala/bin/scala")

; for install-elisp
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/site-lisp")

; for grep-edit
(require 'grep-edit)
(global-set-key [f2] 'lgrep)

; for speedbar
(require 'sr-speedbar)

(defun my-speedbar-expand-line ()
  (interactive)
  (if (= (point-max) (progn (speedbar-expand-line) (point-max)))
      (save-current-buffer
        (speedbar-edit-line))))

(when (locate-library "speedbar")
  (require 'speedbar)
  ;; "a" で無視ファイル表示/非表示のトグル
  (define-key speedbar-file-key-map "a" 'speedbar-toggle-show-all-files)
  ;; ← や → でもディレクトリを開閉 ;;デフォルト: "=" "+", "-"
  (define-key speedbar-file-key-map [right] 'my-speedbar-expand-line)
  (define-key speedbar-file-key-map "\C-f" 'my-speedbar-expand-line)
  (define-key speedbar-file-key-map [left] 'speedbar-contract-line)
  (define-key speedbar-file-key-map "\C-b" 'speedbar-contract-line)
  ;; BS でも上位ディレクトリへ ;;デフォルト: "U"
  (define-key speedbar-file-key-map [backspace] 'speedbar-up-directory)
  (define-key speedbar-file-key-map "\C-h" 'speedbar-up-directory)
  ;; 起動位置を直接指定する
  (setq speedbar-frame-parameters
        (append (list '(top . 40)
                      '(left . 780)
                      '(width . 25))
                speedbar-frame-parameters))
  ;; Speedbar で表示するファイルタイプ
;  (setq speedbar-supported-extension-expressions
;        (append '(".el" ".[ch]\\(pp\\|\\+\\+\\)?" ".java" ".tex\\(i\\(nfo\\)?\\)?"
;                  ".s?html?" ".xml" ".dtd" ".css" ".js"
;                  ".gif" ".jpe?g" ".png")))
  ) ;; end of speedbar

;; F12 で Speedbar
(global-set-key [f12] 'sr-speedbar-toggle)
