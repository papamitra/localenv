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
;(global-set-key [?\C-q] 'elscreen-kill) ; C-q [TAB]を使いたいのでコメントアウト

;; 対応するカッコをハイライト
(show-paren-mode)

;moccur
(require 'color-moccur)
(require 'moccur-edit)

;(load "term/keyswap")
(global-set-key [backspace] 'backward-delete-char)
(keyboard-translate ?\C-h 'backspace)
(global-set-key [delete] 'delete-char)

; color-mode
(require 'color-theme)

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

;(require 'migemo)
(load "migemo")

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

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

; for javascript
;(autoload 'javascript-mode "javascript" nil t) (setq auto-mode-alist (cons '("\\.js$" . javascript-mode) auto-mode-alist))

(let ((term (getenv "TERM")))
  (if (not (or (equal term "xterm") (equal term "xterm-color") (equal term "screen") (equal term "linux")))
      (progn
	(load "./site-lisp/my-color-theme.el")
	(my-color-theme))))

;; C-x bで存在しないバッファを指定して新規バッファを開いたときにはデフォルトでlisp-interaction-modeが起動する。
(setq default-major-mode 'lisp-interaction-mode)

; 行番号をつける
;(require 'linum)
;(global-linum-mode)

;; PCのようなregin選択を可能に
(pc-selection-mode 1)

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

; for scala
(add-to-list 'load-path "/home/insight/opt/scala/misc/scala-tool-support/emacs")
(require 'scala-mode-auto)
(setq scala-interpreter "~/opt/scala/bin/scala")

(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'load-path "~/opt/ensime/dist/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; auto-install
(setq install-elisp-repository-directory "~/.emacs.d/site-lisp")
(setq auto-install-directory "~/.emacs.d/site-lisp")

(require 'auto-install)

;; auto-installによってインストールされるEmacs Lispをロードパスに加える
;;(add-to-list 'load-path auto-install-directory)
;; 起動時にEmacsWikiのページ名を補完候補に加える
(auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
(auto-install-compatibility-setup)
;; ediff関連のバッファを１つのフレームにまとめる
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


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

;; egg
(require 'egg)

(require 'gtags) 
(add-hook 'java-mode-hook (lambda () (gtags-mode 1))) 
(add-hook 'c-mode-hook (lambda () (gtags-mode 1))) 
(add-hook 'c++-mode-hook (lambda () (gtags-mode 1))) 

;; elをemacswikiなどからDLしてくる
(add-to-list 'load-path "~/.emacs.d/site-lisp") 
(require 'install-elisp) 
(setq install-elisp-repository-directory "~/.emacs.d/site-lisp")

;; anything
(require 'anything-startup)
(require 'anything)
(require 'anything-config)
(require 'anything-etags)
(require 'anything-gtags)

(setq anything-sources
      '(anything-c-source-buffers
	anything-c-source-imenu
	anything-c-source-etags-select
	anything-c-source-gtags-select
	))

(global-set-key (kbd "C-:") 'anything)

(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-x b") 'anything-for-files)


;; redo+.el
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; recentf
;; 最近のファイルの500個を保存する
(setq recentf-max-saved-itemds 500)
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)
