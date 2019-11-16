;;; org-jujutsu-site.el
(require 'ox-html)

;;; Define Back-End

(org-export-define-backend 'jujutsu-site
  '((bold . org-html-bold)
    (center-block . org-html-center-block)
    (clock . org-html-clock)
    (code . org-html-code)
    (drawer . org-html-drawer)
    (dynamic-block . org-html-dynamic-block)
    (entity . org-html-entity)
    (example-block . org-html-example-block)
    (export-block . org-html-export-block)
    (export-snippet . org-html-export-snippet)
    (fixed-width . org-html-fixed-width)
    (footnote-definition . org-html-footnote-definition)
    (footnote-reference . org-html-footnote-reference)
    (headline . org-html-headline)
    (horizontal-rule . org-html-horizontal-rule)
    (inline-src-block . org-html-inline-src-block)
    (inlinetask . org-html-inlinetask)
    (inner-template . org-html-inner-template)
    (italic . org-html-italic)
    (item . org-html-item)
    (keyword . org-html-keyword)
    (latex-environment . org-html-latex-environment)
    (latex-fragment . org-html-latex-fragment)
    (line-break . org-html-line-break)
    (link . org-html-link)
    (node-property . org-html-node-property)
    (paragraph . org-html-paragraph)
    (plain-list . org-html-plain-list)
    (plain-text . org-html-plain-text)
    (planning . org-html-planning)
    (property-drawer . org-html-property-drawer)
    (quote-block . org-html-quote-block)
    (radio-target . org-html-radio-target)
    (section . org-html-section)
    (special-block . org-html-special-block)
    (src-block . org-html-src-block)
    (statistics-cookie . org-html-statistics-cookie)
    (strike-through . org-html-strike-through)
    (subscript . org-html-subscript)
    (superscript . org-html-superscript)
    (table . org-html-table)
    (table-cell . org-html-table-cell)
    (table-row . org-html-table-row)
    (target . org-html-target)
    (template . org-jujutsu-site-template)
    (timestamp . org-html-timestamp)
    (underline . org-html-underline)
    (verbatim . org-html-verbatim)
    (verse-block . org-html-verse-block))
  :filters-alist '((:filter-options . org-html-infojs-install-script)
		   (:filter-parse-tree . org-html-image-link-filter)
		   (:filter-final-output . org-html-final-function))
  :menu-entry
  '(?w "Export to Website "
       ((?H "As HTML buffer" org-html-export-as-html)
	(?h "As HTML file" org-html-export-to-html)
	(?o "As HTML file and open"
	    (lambda (a s v b)
	      (if a (org-html-export-to-html t s v b)
		(org-open-file (org-html-export-to-html nil s v b)))))))
  :options-alist
  '((:html-doctype "HTML_DOCTYPE" nil org-html-doctype)
    (:html-container "HTML_CONTAINER" nil org-html-container-element)
    (:description "DESCRIPTION" nil nil newline)
    (:keywords "KEYWORDS" nil nil space)
    (:html-html5-fancy nil "html5-fancy" org-html-html5-fancy)
    (:html-link-use-abs-url nil "html-link-use-abs-url" org-html-link-use-abs-url)
    (:html-link-home "HTML_LINK_HOME" nil org-html-link-home)
    (:html-link-up "HTML_LINK_UP" nil org-html-link-up)
    (:html-mathjax "HTML_MATHJAX" nil "" space)
    (:html-postamble nil "html-postamble" org-html-postamble)
    (:html-preamble nil "html-preamble" org-html-preamble)
    (:html-head "HTML_HEAD" nil org-html-head newline)
    (:html-head-extra "HTML_HEAD_EXTRA" nil org-html-head-extra newline)
    (:subtitle "SUBTITLE" nil nil parse)
    (:html-head-include-default-style
     nil "html-style" org-html-head-include-default-style)
    (:html-head-include-scripts nil "html-scripts" org-html-head-include-scripts)
    (:html-allow-name-attribute-in-anchors
     nil nil org-html-allow-name-attribute-in-anchors)
    (:html-divs nil nil org-html-divs)
    (:html-checkbox-type nil nil org-html-checkbox-type)
    (:html-extension nil nil org-html-extension)
    (:html-footnote-format nil nil org-html-footnote-format)
    (:html-footnote-separator nil nil org-html-footnote-separator)
    (:html-footnotes-section nil nil org-html-footnotes-section)
    (:html-format-drawer-function nil nil org-html-format-drawer-function)
    (:html-format-headline-function nil nil org-html-format-headline-function)
    (:html-format-inlinetask-function
     nil nil org-html-format-inlinetask-function)
    (:html-home/up-format nil nil org-html-home/up-format)
    (:html-indent nil nil org-html-indent)
    (:html-infojs-options nil nil org-html-infojs-options)
    (:html-infojs-template nil nil org-html-infojs-template)
    (:html-inline-image-rules nil nil org-html-inline-image-rules)
    (:html-link-org-files-as-html nil nil org-html-link-org-files-as-html)
    (:html-mathjax-options nil nil org-html-mathjax-options)
    (:html-mathjax-template nil nil org-html-mathjax-template)
    (:html-metadata-timestamp-format nil nil org-html-metadata-timestamp-format)
    (:html-postamble-format nil nil org-html-postamble-format)
    (:html-preamble-format nil nil org-html-preamble-format)
    (:html-table-align-individual-fields
     nil nil org-html-table-align-individual-fields)
    (:html-table-caption-above nil nil org-html-table-caption-above)
    (:html-table-data-tags nil nil org-html-table-data-tags)
    (:html-table-header-tags nil nil org-html-table-header-tags)
    (:html-table-use-header-tags-for-first-column
     nil nil org-html-table-use-header-tags-for-first-column)
    (:html-tag-class-prefix nil nil org-html-tag-class-prefix)
    (:html-text-markup-alist nil nil org-html-text-markup-alist)
    (:html-todo-kwd-class-prefix nil nil org-html-todo-kwd-class-prefix)
    (:html-toplevel-hlevel nil nil org-html-toplevel-hlevel)
    (:html-use-infojs nil nil org-html-use-infojs)
    (:html-validation-link nil nil org-html-validation-link)
    (:html-viewport nil nil org-html-viewport)
    (:html-inline-images nil nil org-html-inline-images)
    (:html-table-attributes nil nil org-html-table-default-attributes)
    (:html-table-row-open-tag nil nil org-html-table-row-open-tag)
    (:html-table-row-close-tag nil nil org-html-table-row-close-tag)
    (:html-xml-declaration nil nil org-html-xml-declaration)
    (:html-klipsify-src nil nil org-html-klipsify-src)
    (:html-klipse-css nil nil org-html-klipse-css)
    (:html-klipse-js nil nil org-html-klipse-js)
    (:html-klipse-selection-script nil nil org-html-klipse-selection-script)
    (:infojs-opt "INFOJS_OPT" nil nil)
    ;; Redefine regular options.
    (:creator "CREATOR" nil org-html-creator-string)
    (:with-latex nil "tex" org-html-with-latex)
    ;; Retrieve LaTeX header for fragments.
    (:latex-header "LATEX_HEADER" nil nil newline)))

;; Modification to org-html-template to give the layout I'm after
(defun org-jujutsu-site-template (contents info)
  "Return complete document string after HTML conversion.
CONTENTS is the transcoded contents string.  INFO is a plist
holding export options."
  (concat
   (when (and (not (org-html-html5-p info)) (org-html-xhtml-p info))
     (let* ((xml-declaration (plist-get info :html-xml-declaration))
	    (decl (or (and (stringp xml-declaration) xml-declaration)
		      (cdr (assoc (plist-get info :html-extension)
				  xml-declaration))
		      (cdr (assoc "html" xml-declaration))
		      "")))
       (when (not (or (not decl) (string= "" decl)))
	 (format "%s\n"
		 (format decl
			 (or (and org-html-coding-system
				  (fboundp 'coding-system-get)
				  (coding-system-get org-html-coding-system 'mime-charset))
			     "iso-8859-1"))))))
   (org-html-doctype info)
   "\n"
   (concat "<html"
	   (cond ((org-html-xhtml-p info)
		  (format
		   " xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"%s\" xml:lang=\"%s\""
		   (plist-get info :language) (plist-get info :language)))
		 ((org-html-html5-p info)
		  (format " lang=\"%s\"" (plist-get info :language))))
	   ">\n")
   "<head>\n"
   (org-html--build-meta-info info)
   (org-html--build-head info)
   (org-html--build-mathjax-config info)
   "</head>\n"
   "<body>\n"

   ;; In body we want:
   ;; - nav element
   ;; - card
   ;; - card body
   ;; - card title
   ;; - contents
   ;; - end card body
   ;; - end card
   ;; - end body
   
   ;; Preamble.
   (org-html--build-pre/postamble 'preamble info)
   ;; Document contents.

   (org-jujutsu-nav (plist-get info :this-file) (plist-get info :base-directory))

   "<div class=\"card\">\n"
   "<div class=\"card-body\">\n"
   ;; Document title - we want to put this as the first part of the card element.
   (when (plist-get info :with-title)
     (let ((title (and (plist-get info :with-title)
		       (plist-get info :title)))
	   (subtitle (plist-get info :subtitle))
	   (html5-fancy (org-html--html5-fancy-p info)))
       (when title
	 (format "<h1 class=\"card-title\"> %s </h1>\n"
          	 (org-export-data title info)))))


   contents
   
   ;; Closing document.
   "</div>\n</div>\n" 

   ;; Postamble.
   (org-html--build-pre/postamble 'postamble info)
   "</body>\n</html>"))



(defun org-jujutsu-nav (file base)
  "<nav class=\"navbar navbar-expand-md navbar-dark bg-primary\">
  <a class=\"navbar-brand\" href=\"/\">Warborough Jujutsu</a>
  <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarSupportedContent\" aria-controls=\"navbarSupportedContent\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">
  <span class=\"navbar-toggler-icon\"></span>
  </button>

  <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">
  <ul class=\"navbar-nav mr-auto\">
  <li class=\"nav-item\" ><a class=\"nav-link\" href='/classdetails/'>Class details</a></li>
  <li class=\"nav-item\"><a class=\"nav-link\" href='/blog/'>Blog</a></li>
  <li class=\"nav-item\"><a class=\"nav-link\" href='/kata/'>Technique list</a></li>
  </ul>
  </div>
  </nav>")



(defun org-jujutsu-site-publish-to-html (plist filename pub-dir)
  "Publish an org file to HTML.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name."
  (org-publish-org-to 'jujutsu-site filename
		      (concat "." (or (plist-get plist :html-extension)
				      org-html-extension
				      "html"))
		      (plist-put plist :this-file filename)
                      pub-dir))


(provide 'org-jujutsu-site)
