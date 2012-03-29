;;; load-path�̒ǉ��֐�
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;;; load-path�ɒǉ�����t�H���_
;;; 2�ȏ�w�肷��ꍇ�̌` -> (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp" "conf" "auto-install" "elpa")

;;; install-elisp
(require 'install-elisp)

;;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t) ;; optional

;;; ELPA - package.el
;; ref) Emacs ���H���� p.116
(when (require 'package nil t)
  (add-to-list 'package-archives
			   '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA", "http://tromey.com/elpa/"))
  (package-initialize))

;;; �X�^�[�g�A�b�v��\��
(setq inhibit-startup-screen t)

;;; �c�[���o�[��\��
(tool-bar-mode 0)

;;; �^�C�g���o�[�Ƀt�@�C���̃t���p�X��\��
(setq frame-title-format "%f")

;;; �����R�[�h
;(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'cp932)
(setq locale-coding-system 'utf-8)

;;; ���ʂ͈͓̔��������\��
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)

;;; ���ʂ͈̔͐F
(set-face-background 'show-paren-match-face "#800")

;;; Windows �ŉp���� DejaVu Sans Mono�A���{���Meiryo���w��
(when (eq window-system 'w32)
  (set-face-attribute 'default nil
                      :family "DejaVu Sans Mono"
                      :height 100)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))

;;; �o�b�N�A�b�v���c���Ȃ�
(setq make-backup-files nil)

;;; �s�ԍ��\��
(global-linum-mode)

;;; Color Theme ��L���ɂ���
(require 'color-theme)
(color-theme-initialize)
;(color-theme-hober)
(color-theme-clarity)

;;; C# ���[�h
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;;; ASPX ���[�h
(autoload 'aspx-mode "aspx-mode" "Major mode for editing apsx code." t)
(setq auto-mode-alist
	  (append '(("\\.aspx$" . aspx-mode)) auto-mode-alist))
(setq auto-mode-alist
	  (append '(("\\.ascx$" . aspx-mode)) auto-mode-alist))

;;; TAB��
(setq-default tab-width 4)

;;; Shift + �J�[�\���L�[�@�Ńo�b�t�@�ړ�
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;;; �c�[���o�[���\��
(tool-bar-mode -1)

;;; ���j���[�o�[���\��
;(menu-bar-mode -1)

;;; �}�E�X�̃z�C�[���X�N���[���X�s�[�h�𒲐�
;; (�A�����ĉ񂵂Ă���ƂƂ�ł��Ȃ������ɂȂ��Ă��܂��B����Logicool�̃}�E�X)
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)

;;; SQL-mode
(require 'sql)
(add-hook 'sql-interactive-mode-hook
          #'(lambda ()
              (interactive)
              (set-buffer-process-coding-system 'sjis-unix 'sjis-unix )
              (setq show-trailing-whitespace nil)))

;;; Tramp (FTP/SSH tool)
(require 'tramp)

;;; Git�t�����g�G���hEgg�̐ݒ�
(when (executable-find "git")
  (require 'egg nil t))

;;; SVN�t�����g�G���h�̐ݒ�
(when (executable-find "svn")
  (setq svn-status-verbose nil)
  (autoload 'svn-status "psvn" "Run `svn status'." t))

;;; color-moccur
;; ref) Emacs ���H���� p.132
(when (require 'color-moccur nil t)
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(setq moccur-use-migemo t)))

;;; moccur-edit
;; ref) Emacs ���H���� p.134
(require 'moccur-edit nil t)

;;; wgrep
;; ref) Emacs ���H���� p.136
(require 'wgrep nil t)

;;; auto-complete
;; ref) Emacs ���H���� p.131
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
			   "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;; multi-term
(require 'multi-term nil t)

;;; Anything
;(require 'anything-startup)

;;; SLIME
(setq inferior-lisp-program "sbcl") ; My Lisp system
(require 'slime)
(slime-setup '(slime-fancy))
(require 'slime-repl)

;;; ���샆�[�e�B���e�B�֐�
;;; C#: sql.Append(" "); ����
(defun remove-sql-append ()
  (replace-regexp "^[ ^I]+sql.Append(\"" "" nil)
  (replace-regexp "\");$" "" nil))
