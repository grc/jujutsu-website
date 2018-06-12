;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

;; set site root to directory containing this .dir-locals


((nil . ((eval . (setq-local site-root
                             (locate-dominating-file default-directory
                                                     ".dir-locals.el")))
         (eval . (setq-local org-html-postamble nil )))))
