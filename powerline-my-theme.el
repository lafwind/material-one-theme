;;; package --- summary
;;; commentary:

;;; Code:

(setq powerline-default-separator (if (display-graphic-p) 'arrow
                                    nil))

(defface my-pl-segment0-active
  ;; blue
  ;; '((t (:foreground "black" :weight normal :background "#669966")))
  '((t (:foreground "#E5E3F5" :weight normal :background "#303F9F")))
  "Powerline first segment active face.")
(defface my-pl-segment0-inactive
  ;; '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  '((t (:foreground "#CEBFF3" :background "#6A1B9A")))
  "Powerline first segment inactive face.")

(defface my-pl-segment1-active
  ;; red
  ;; '((t (:foreground "black" :weight normal :background "#996666")))
  '((t (:foreground "#E5E3F5" :weight normal :background "#880E4F")))
  "Powerline first segment active face.")
(defface my-pl-segment1-inactive
  ; '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  '((t (:foreground "#CEBFF3" :background "#6A1B9A")))
  "Powerline first segment inactive face.")

(defface my-pl-segment2-active
  ;; green
  ;; '((t (:foreground "#E5E3F5" :weight normal :background "#6666aa")))
  '((t (:foreground "#E5E3F5" :weight normal :background "#2E7D32")))
  "Powerline second segment active face.")
(defface my-pl-segment2-inactive
  ;; '((t (:foreground "#CEBFF3" :weight normal :background "#3A2E58")))
  '((t (:foreground "#CEBFF3" :weight normal :background "#6A1B9A")))
  "Powerline second segment inactive face.")

(defface my-pl-segment3-active
  ;; '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  '((t (:foreground "#CEBFF3" :background "#6A1B9A")))
  "Powerline third segment active face.")
(defface my-pl-segment3-inactive
  ;; '((t (:foreground "#CEBFF3" :background "#3A2E58")))
  '((t (:foreground "#CEBFF3" :background "#6A1B9A")))
  "Powerline third segment inactive face.")

(defcustom powerline-display-buffer-size t
  "When non-nil, display the buffer size."
  :type 'boolean)

(defcustom powerline-display-mule-info t
  "When non-nil, display the mule info."
  :type 'boolean)

(defcustom powerline-display-hud t
  "When non-nil, display the hud."
  :type 'boolean)

(defun powerline-my-theme ()
  "Set up my custom Powerline with Evil indicators."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (seg0 (if active 'my-pl-segment0-active 'my-pl-segment0-inactive))
                          (seg1 (if active 'my-pl-segment1-active 'my-pl-segment1-inactive))
                          (seg2 (if active 'my-pl-segment2-active 'my-pl-segment2-inactive))
                          (seg3 (if active 'my-pl-segment3-active 'my-pl-segment3-inactive))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list
                                     (powerline-raw " " nil 'l)
                                     (let ((evil-face (powerline-evil-face)))
                                       (if evil-mode
                                           (powerline-raw (powerline-evil-tag) nil)
                                         ))
                                     (powerline-raw " " nil 'l)
                                     (if evil-mode
                                         (funcall separator-left nil seg1))
                                     (powerline-buffer-id seg1 'l)
                                     (powerline-raw "[%*]" seg1 'l)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format seg1 'l))
                                     (powerline-raw " " seg1)
                                     (funcall separator-left seg1 seg0)
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object seg0 'l))
                                     (powerline-major-mode seg0 'l)
                                     (powerline-process seg0)
                                     (powerline-minor-modes seg0 'l)
                                     (powerline-narrow seg0 'l)
                                     (powerline-raw " " seg0)
                                     (funcall separator-left seg0 seg3)
                                     (powerline-vc seg3 'r)
                                     (when (bound-and-true-p nyan-mode)
                                       (powerline-raw (list (nyan-create)) seg3 'l))))
                          (rhs (list (powerline-raw global-mode-string seg3 'r)
                                     (funcall separator-right seg3 seg2)
                                     (unless window-system
                                       (powerline-raw (char-to-string #xe0a1) seg2 'l))
                                     (powerline-raw "%4l" seg2 'l)
                                     (powerline-raw ":" seg2 'l)
                                     (powerline-raw "%3c" seg2 'r)
                                     (funcall separator-right seg2 seg1)
                                     (powerline-raw " " seg1)
                                     (powerline-raw "%6p" seg1 'r)
                                     (when powerline-display-hud
                                       (powerline-hud seg1 seg3))
				     (powerline-raw " " seg1)
				     )))
		     (concat (powerline-render lhs)
                             (powerline-fill seg3 (powerline-width rhs))
                             (powerline-render rhs)
                      ))))))


(provide 'powerline-my-theme)

;;; powerline-my-theme.el ends here
