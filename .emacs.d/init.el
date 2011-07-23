;;; -*- Emacs-Lisp -*-
;;; -*- coding: utf-8 -*-

(setq load-path
      (append
       (list
       (expand-file-name "~/.emacs.d/")
       (expand-file-name "~/.emacs.d/site-lisp/")
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

;; skk
;(set-input-method "japanese-skk")
;(inactivate-input-method)

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

;; C-x bで存在しないバッファを指定して新規バッファを開いたときにはデフォルトでlisp-interaction-modeが起動する。
(setq default-major-mode 'lisp-interaction-mode)

; 行番号をつける
;(require 'linum)
;(global-linum-mode)

;; PCのようなregin選択を可能に
(pc-selection-mode 1)

;; shift-tabでwindowを移動する
(global-set-key [backtab] 'other-window)

;; 現在の行をハイライト
;(global-hl-line-mode t)

; for scala
(add-to-list 'load-path "~/opt/scala/misc/scala-tool-support/emacs")
(require 'scala-mode-auto)
(setq scala-interpreter "~/opt/scala/bin/scala")

(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'load-path "~/opt/ensime/dist/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(defun my-scala-mode-hook ()
  (define-key scala-mode-map (kbd "C-c l") 'scala-mode-feature-tags-load)
  (define-key scala-mode-map (kbd "C-c .") 'find-tag)
)
(add-hook 'scala-mode-hook 'my-scala-mode-hook)

;; auto-install
(setq install-elisp-repository-directory "~/.emacs.d/site-lisp/")
(setq auto-install-directory "~/.emacs.d/site-lisp/")

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
;(require 'grep-edit)
(global-set-key [f2] 'moccur-grep-find)

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
;(require 'anything)
;(require 'anything-config)
;(require 'anything-etags)
;(require 'anything-gtags)
;(require 'anything-ipa)

;(setq anything-sources
;      '(anything-c-source-ipa
;	anything-c-source-imenu
;	anything-c-source-etags-select
;	anything-c-source-gtags-select
;	))

;(global-set-key (kbd "C-:") 'anything)

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

;;; 履歴を次回のEmacs起動時にも保存する
(savehist-mode 1)

;;; ファイル内のカーソル一を記憶する
(setq-default save-place t)
(require 'saveplace)

;;; モードラインに時刻を表示
(display-time)

;;; 行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

;;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ログの記録行数を増やす
(setq message-log-max 10000)

;;; ミニバッファを再帰的に呼び出せるようにする
(setq enable-recursive-minibuffers t)

;;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;;;　履歴をたくさん保存する
(setq history-length 1000)

;;; キーストロークをエコーエリアに早く表示する
;(setq echo-keystrokes 0.1)

;;; ツールバーを消す
(tool-bar-mode -1)

;; ipa
(require 'ipa)

(add-to-list 'load-path "~/.emacs.d/site-lisp/twittering-mode")

(require 'twittering-mode)

(setq twittering-status-format
      "%C{%Y/%m/%d %H:%M:%S} %s > %T // from %f%L%r%R")

(setq twittering-update-status-function 'twittering-update-status-from-pop-up-buffer)

;;; load local file
(if (file-exists-p "./local.el")
    (load "load.el"))

;; for f#
(setq load-path (cons "~/.emacs.d/site-lisp/fsharp" load-path))
(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)

(setq inferior-fsharp-program "fsharpi --gui-")
(setq fsharp-compiler "fsharpc")
(put 'set-goal-column 'disabled nil)

;; for mozc
(load-file "/usr/share/emacs/site-lisp/emacs-mozc/mozc.el")
(setq default-input-method "japanese-mozc")
(global-set-key (kbd "C-o") 'toggle-input-method)

(let ((term (getenv "TERM")))
  (if (not (or (equal term "xterm") (equal term "xterm-color") (equal term "screen") (equal term "linux") (equal term "screen.mlterm")))
      (progn
	(load "~/.emacs.d/site-lisp/my-color-theme.el")
	(my-color-theme))))

;; yasnippet
(add-to-list 'load-path
	     "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/site-lisp/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/snippets")
