;; org mode export
(require 'org-latex)
(setq org-latex-to-pdf-process
       '("pdflatex -interaction nonstopmode %b"
         "bibtex %b"
         "pdflatex -interaction nonstopmode %b"
         "pdflatex -interaction nonstopmode %b"
	 "rm %b.bbl %b.blg %b.tex"))

;; bibtex

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c c") 'reftex-citation))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq reftex-cite-format 'natbib)


;; div metoder og andre hjelpefunksjoner

;; (defun wc ()
;;   "word count"
;;   (interactive)
;;   (shell-command (concat "wc -w " (buffer-file-name))))

(defun insert-quote ()
  "Insert latex-quote at cursor point."
  (interactive)
  (insert "\\begin{quote}\n \n\\end{quote}")
  (backward-char 13))

(defun insert-comment ()
  "Insert latex-comment at cursor point."
  (interactive)
  (insert "\\begin{comment}\n \n\\end{comment}")
  (backward-char 15))


;; to copy paste between emacs and other apps
;; from http://www.emacswiki.org/emacs/CopyAndPaste
(setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; visual
(set-foreground-color "grey")
(set-background-color "black")

(mouse-avoidance-mode 'banish)

(display-time)
(line-number-mode 't) ;; linjenummer i "statusbaren"

(ido-mode)

(add-hook 'text-mode-hook 'visual-line-mode)
;;(set-fill-column 90)
(longlines-mode)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(global-linum-mode nil) ;; linjenummer
 '(scroll-bar-mode nil)
 '(tool-bar-mode)
 '(menu-bar-mode))


;;(set-default-font "Inconsolata-11")
;;(set-default-font "Droid Sans Mono-10")


(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; allow for export=>beamer by placing
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
 (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n

      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{}}}}\n          
       \\subject{{{{}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

;; av en eller annen grunn mÃ¥tte jeg harkode dette inn.. 
(add-to-list 'org-export-latex-classes
 '("article"
 "\\documentclass[12pt,twoside]{article}\n\\usepackage[utf8]{inputenc}\n\\usepackage[T1]{fontenc}\n\\usepackage{graphicx}\n\\usepackage{longtable}\n\\usepackage{float}\n\\usepackage{wrapfig}\n\\usepackage{soul}\n\\usepackage{amssymb}\n\\usepackage{hyperref}"
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
  ("\\paragraph{%s}" . "\\paragraph*{%s}")
  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode)) ;; c-h v, når auto-mode-alist er markert for å se resten av  variablene
(add-to-list 'auto-mode-alist '("\\.vssettings\\'" . nxml-mode)) 

;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; This from a japanese individual.  I hope it works.
(setq default-buffer-file-coding-system 'utf-8)
;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE 
(set-clipboard-coding-system 'utf-16le-dos)
