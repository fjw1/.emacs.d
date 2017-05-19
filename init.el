;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;;;;;; Package manager and file installation
;;;;;;;;;;;;;;;;;;;;;;

(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")))


	
;;;;;;;;; Operational parts	  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;	  

;;; Auto-complete

(require 'auto-complete)
(ac-config-default)
(global-auto-complete-mode t)

;;; Snippets

(require 'yasnippet)
(yas/initialize)
(yas-global-mode 1)

	   
;;; Other requirements
	   
(require 'autopair)
(require 'flycheck)
(global-flycheck-mode t)
(require 'helm-config) ; File explorer

(require 'ido)
(ido-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(global-visual-line-mode t) ; Word wrap


;;;;;;;;;;;;;; Customising the look of emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(load-theme 'zenburn t)

;;; Font

(set-face-font 'menu "-outline-Operator Mono Light-light-normal-normal-mono-*-*-*-c-*-iso10646-1")
(set-face-font 'default "-outline-Operator Mono Light-light-normal-normal-mono-*-*-*-c-*-iso10646-1")

;(add-to-list 'default-frame-alist '(font . "-outline-Operator Mono Light-light-normal-normal-mono-*-*-*-c-*-iso10646-1" ))
(set-face-attribute 'default nil :height 140) ; Rule is value/10 = pt, so that 160 = 16pt

;(let ((font "Operator Mono Light"))
 ; (set-frame-font font)
  ;(add-to-list 'default-frame-alist
   ;            `(font . ,font)))

;;; Bracket matching

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;;; Ligatures

;(when (window-system)
;  (set-default-font "Fira Code"))
;(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
;	       (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
;	       (36 . ".\\(?:>\\)")
;	       (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
;	       (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
;	       (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
;	       (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
;	       (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
;	       (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
;	       (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
;	       (48 . ".\\(?:x[a-zA-Z]\\)")
;	       (58 . ".\\(?:::\\|[:=]\\)")
	;       (59 . ".\\(?:;;\\|;\\)")
;	       (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
;	       (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
;	       (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
;	       (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
;	       (91 . ".\\(?:]\\)")
;	       (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
;	       (94 . ".\\(?:=\\)")
;	       (119 . ".\\(?:ww\\)")
;	       (123 . ".\\(?:-\\)")
;	       (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
;	       (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
;	       )
;	     ))
 ; (dolist (char-regexp alist)
 ;   (set-char-table-range composition-function-table (car char-regexp)
;			  `([,(cdr char-regexp) 0 font-shape-gstring]))))

			  
			  

;;;;;;;;;;;;;;;;; Mode configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; LaTeX 

(require 'tex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)


; To run latexmk
(add-hook 'LaTeX-mode-hook (lambda ()
  (push 
    '("Latexmk" "latexmk -pdf -xelatex %s" TeX-run-command nil t 
      :help "Run Latexmk on file")
    TeX-command-list)))


;(defun flymake-get-tex-args (file-name)
  ;(list "xelatex"
    ;    (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(setq-default TeX-engine 'xetex)

;(add-hook 'LaTeX-mode-hook 'flymake-mode)

; To stop unmatched paranethesis
;(add-to-list
 ;   `flymake-err-line-patterns
 ;   '("Runaway argument?" nil nil nil))

(require 'tex-site)
(add-hook ’LaTeX-mode-hook ’turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook ’latex-mode-hook ’turn-on-reftex) ; with Emacs latex mode

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-view-program-list
   '(("Sumatra PDF" ("\"C:/Program Files (x86)/SumatraPDF/sumatraPDF.exe\" -reuse-instance"
                      (mode-io-correlate " -forward-search %b %n ") " %o"))))

(eval-after-load 'tex
  '(progn
     (assq-delete-all 'output-pdf TeX-view-program-selection)
     (add-to-list 'TeX-view-program-selection '(output-pdf "Sumatra PDF"))))




;;; Python

(elpy-enable)

;(when (load "flymake" t)
  ; (defun flymake-pylint-init ()
  ;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;                      'flymake-create-temp-inplace))
  ;          (local-file (file-relative-name
   ;                      temp-file
  ;                       (file-name-directory buffer-file-name))))
  ;     (list "epylint" (list local-file))))
  ; (add-to-list 'flymake-allowed-file-name-masks
 ;               '("\\.py\\'" flymake-pylint-init)))


; (add-hook 'python-mode-hook '(lambda () (flymake-mode)))



;;;;;;;;;;;;;;;;;;;; Load last
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy yasnippet zenburn-theme zenburn yasnippet-bundle wgrep tablist tabbar scratch s rainbow-delimiters pyvenv python-mode project-local-variables pretty-mode material-theme latex-preview-pane highlight-indentation helm fullframe flycheck find-file-in-project exec-path-from-shell diminish company command-log-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized autopair auto-complete auctex-latexmk))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
			  













 
 
 
 
 
 

