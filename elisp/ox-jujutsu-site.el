;;; ox-jujutsu-site.el --- Org export backend for html used on jujutsu web site.

;;; Commentary:
;; Org exporter back end to generate the bootstrap based jujutsu web
;; site to be found at http://jujutsu.org.uk.





;;; Code:

(require 'ox-html)
(require 's)

(defvar org-jujutsu-nav-items
  '(("/classdetails/" . "Class details")
    ("/blog/" . "Blog")
    ("/kata/" . "Kata"))
  "List of navigation menu URLs and their associated labels.")

;;; Define Back-End
(org-export-define-derived-backend 'jujutsu-site 'html
  :translate-alist '((template . org-jujutsu-site-template))
  :menu-entry '(?j "Jujutsu site" org-html-export-to-html))


;; Based on org-html-template modified to give the layout I'm after
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

   (org-jujutsu-site-head contents info)
   (org-jujutsu-site-body contents
                          (plist-get info :input-file)
                          (plist-get info :base-directory))
   "</html>\n"))



(defun org-jujutsu-site-head (contents info)
  "Return the HTML head for the web page."
  (let ((file (plist-get info :input-file))
        (directory (plist-get info :base-directory)))
    (concat "<head>\n"
            (org-html--build-meta-info info)
            (org-html--build-head info)
            (org-jujutsu--build-canonical-info file directory)
            "</head>\n")))


(defun org-jujutsu-site-body (contents file directory)
  "Return the HTML body for the web page.  In the body we want:
   - nav element
   - card
   - card body
   - card title
   - contents
   - end card body
   - end card
   - end body
"
  (concat  "<body>\n"
           (org-html--build-pre/postamble 'preamble info)
           (org-jujutsu-nav file directory)
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

           "</div>\n"  ; card-body
           "</div>\n"  ; card

           ;; Postamble.
           (org-html--build-pre/postamble 'postamble info)
           org-jujutsu-bootstrap-scripts
           "</body>\n"))

(defun org-jujutsu--build-canonical-info (file directory)
  "Return the html for a canonical link.
See https://support.google.com/webmasters/answer/139066?hl=en for details."
  (format "<link rel=\"canonical\" href=\"https://jujutsu.org.uk/%s\">\n"
          (let ((path (file-name-sans-extension
                       (file-relative-name file directory))))
            ;; We use the directory name as the canonical name for index files.  
            (s-chop-suffix "index" path))))

(defun org-jujutsu--nav-items-html (items file base)
  "Return the html for the navigation items present in the alist ITEMS.
FILE and BASE are used to determine whether or not a particular
navigation link should be disabled'"
  (apply #'concat
         (mapcar (lambda (x)
                   (let ((url (car x))
                         (caption (cdr x)))
                     (format "<li class=\"nav-item\" ><a class=\"nav-link %s\" href='%s'>%s</a></li>\n"
                             (org-jujutsu--disabled-link? url file base)
                             url
                             caption)))
                 items)))

(defun org-jujutsu--disabled-link? (url file base)
  "Return \"disabled \" if file is corresponds to this index file, otherwise the empty string"
  (let ((url-abs-path (concat base url "index.org")))
    (if (string= file url-abs-path)
        " disabled "
      "")))

(defun org-jujutsu-nav (file base)
  (let ((button "<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\"  data-target=\"#navbarSupportedContent\" aria-controls=\"navbarSupportedContent\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">
  <span class=\"navbar-toggler-icon\"></span>
  </button>")
        (nav-bar-start
         "<nav class=\"navbar navbar-expand-md navbar-dark bg-primary\">
  <a class=\"navbar-brand\" href=\"/\">Warborough Jujutsu</a>"))
    (format 
     "%s
      %s
 <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">
  <ul class=\"navbar-nav mr-auto\">
  %s
  </ul>
  </div>
  </nav>\n"
     nav-bar-start
     button
     
     (org-jujutsu--nav-items-html org-jujutsu-nav-items file (expand-file-name base)))))



(defvar org-jujutsu-bootstrap-scripts
  "<script src=\"https://code.jquery.com/jquery-3.2.1.slim.min.js\" integrity=\"sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN\" crossorigin=\"anonymous\"></script>
<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js\" integrity=\"sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q\" crossorigin=\"anonymous\"></script>
<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js\" integrity=\"sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl\" crossorigin=\"anonymous\"></script>    
"
  "JavaScript files required for bootstrap. ")



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
                      plist
                      pub-dir))

(provide 'ox-jujutsu-site)

;;; ox-jujutsu-site.el ends here
