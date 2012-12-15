;;; tabbar-ruler.el --- Setup tabbar to look pretty...
;;
;; Filename: tabbar-ruler.el
;; Description: Changes tabbar setup to be similar to Aquaemacs.
;; Author: Matthew Fidler, Nathaniel Cunningham
;; Maintainer: Matthew L. Fidler
;; Created: Mon Oct 18 17:06:07 2010 (-0500)
;; Version: 0.16
;; Last-Updated: Sat Dec 15 15:44:34 2012 (+0800)
;;           By: Matthew L. Fidler
;;     Update #: 663
;; URL: http://github.com/mlf176f2/tabbar-ruler.el
;; Keywords: Tabbar, Ruler Mode, Menu, Tool Bar.
;; Compatibility: Windows Emacs 23.x
;; Package-Requires: ((tabbar "2.0.1"))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; 
;; * Introduction
;; Tabbar ruler is an emacs package that allows both the tabbar and the
;; ruler to be used together.  In addition it allows auto-hiding of the
;; menu-bar and tool-bar.
;; 
;; 
;; Tabbar appearance based on reverse engineering Aquaemacs code and
;; changing to my preferences, and Emacs Wiki.
;; 
;; Tabbar/Ruler integration is new. Tabbar should be active on mouse
;; move.  Ruler should be active on self-insert commands.
;; 
;; Also allows auto-hiding of toolbar and menu.
;; 
;; To use this, put the library in your load path and use
;; 
;; 
;;   (setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
;;   (setq tabbar-ruler-global-ruler 't) ; if you want a global ruler
;;   (setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.
;;   (setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar
;;   
;;   (require 'tabbar-ruler)
;;   
;; 
;; 
;; 
;; * Known issues
;; the left arrow is text instead of an image.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;; 15-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Made sure that the tabbr-ruler-separator-image is at least 17 pixels high
;; 15-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Attempt to fix another bug on load
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Fixed tabbar ruler so that it loads cold.
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Memoized the tabbar images to speed things up
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Mat`'thew L. Fidler)
;;    Upload to Marmalade 
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Fancy tabs
;; 13-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Added Bug fix for coloring.  Made the selected tab match the default
;;    color in the buffer.  Everything else is grayed out.
;; 10-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Took out a statement that may fix the left-scrolling bug?
;; 10-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Added package-menu-mode to the excluded tabbar-ruler fight modes.
;; 07-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Will no longer take over editing of org source blocks or info blocks.
;; 07-Dec-2012    Matthew L. Fidler
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Changed the order of checking so that helm will work when you move a mouse.
;; 07-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Now works with Helm.  Should fix issue #1
;; 06-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Now colors are based on loaded theme (from minibar).  Also added
;;    bug-fix for setting tabbar colors every time a frame opens.  Also
;;    added a bug fix for right-clicking a frame that is not associated with
;;    a buffer.
;; 1-Mar-2012    Matthew L. Fidler
;;    Last-Updated: Thu Mar  1 08:38:09 2012 (-0600) #656 (Matthew L. Fidler)
;;    Will not change tool-bar-mode in Mac.  It causes some funny
;;    things to happen.
;; 9-Feb-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Feb  9 19:18:21 2012 (-0600) #651 (Matthew L. Fidler)
;;    Will not change the menu bar in a Mac.  Its always there.
;; 14-Jan-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Jan 14 21:58:51 2012 (-0600) #648 (Matthew L. Fidler)
;;    Added more commands that trigger the ruler.
;; 14-Jan-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Jan 14 21:44:32 2012 (-0600) #641 (Matthew L. Fidler)
;;    Added more ruler commands.   It works a bit better
;;    now. Additionally I have changed the ep- to tabbar-ruler-.
;; 14-Jan-2012    Matthew L. Fidler  
;;    Last-Updated: Tue Feb  8 15:01:27 2011 (-0600) #639 (Matthew L. Fidler)
;;    Changed EmacsPortable to tabbar-ruler
;; 08-Feb-2011    Matthew L. Fidler  
;;    Last-Updated: Tue Feb  8 14:59:57 2011 (-0600) #638 (Matthew L. Fidler)
;;    Added ELPA tags.  
;; 08-Feb-2011    Matthew L. Fidler  
;;    Last-Updated: Tue Feb  8 12:47:09 2011 (-0600) #604 (Matthew L. Fidler)
;;    Removed xpm dependencies.  Now no images are required, they are built by the library.
;; 04-Dec-2010    Matthew L. Fidler  
;;    Last-Updated: Sat Dec  4 16:27:07 2010 (-0600) #551 (Matthew L. Fidler)
;;    Added context menu.
;; 01-Dec-2010    Matthew L. Fidler  
;;    Last-Updated: Wed Dec  1 15:26:37 2010 (-0600) #341 (Matthew L. Fidler)
;;    Added scratch buffers to list.
;; 04-Nov-2010
;;    Last-Updated: Thu Nov  4 09:39:14 2010 (-0500) (us041375)
;;    Made tabbar mode default.
;; 02-Nov-2010    Matthew L. Fidler
;;    Last-Updated: Tue Nov  2 10:14:12 2010 (-0500) (Matthew L. Fidler)
;;    Make post-command-hook handle errors gracefully.
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;
;;    Changed behavior when outside the window to assume the last
;;    known mouse position. This fixes the two problems below.
;;
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;
;;    As it turns out when the toolbar is hidden when the mouse is
;;    outside of the emacs window, it also hides when navigating the
;;    menu.  Switching behavior back.
;;
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;    Made popup menu and toolbar be hidden when mouse is oustide of emacs window.
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;    Changed to popup ruler-mode if tabbar and ruler are not displayed.
;; 19-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;    Changed tabbar, menu, toolbar and ruler variables to be buffer
;;    or frame local.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:
(eval-when-compile
  (require 'cl))
(require 'tabbar)
(require 'easymenu)



(defun tabbar-hex-color (color)
  "Gets the hexadecimal value of a color"
  (let ((ret color))
    (cond
     ((string= "#" (substring color 0 1))
      (setq ret (upcase ret)))
     ((color-defined-p color)
      (setq ret (concat "#"
                        (mapconcat
                         (lambda(val)
                           (format "%02X" (* val 255)))
                         (color-name-to-rgb color) ""))))
     (t (setq ret nil)))
    (symbol-value 'ret)))

(defun tabbar-install-faces (&optional frame)
  "Installs faces for a frame."
  (interactive)
  (copy-face 'mode-line 'tabbar-default frame)
  (copy-face 'default 'tabbar-selected frame)
  (copy-face 'shadow 'tabbar-unselected frame)
  
  (set-face-attribute 'tabbar-unselected frame
                      :background "gray50"
                      :foreground "gray10")
  
  
  (copy-face 'mode-line-buffer-id 'tabbar-selected-highlight frame)
  (copy-face 'mode-line-inactive 'tabbar-unselected-highlight frame)
  
  (set-face-attribute 'tabbar-separator frame
                      :inherit 'tabbar-default
                      :box nil)
  
  (set-face-attribute 'tabbar-button frame
                      :inherit 'tabbar-default
                      :box nil))

(add-hook 'after-make-frame-functions 'tabbar-install-faces)

(tabbar-install-faces)


;; Taken from powerline

(defun tabbar-create-or-get-tabbar-cache ()
  "Return a frame-local hash table that acts as a memoization
cache for tabbar. Create one if the frame doesn't have one
yet."
  (or (frame-parameter nil 'tabbar-cache)
      (let ((table (make-hash-table :test 'equal)))
        ;; Store it as a frame-local variable
        (modify-frame-parameters nil `((tabbar-cache . ,table)))
        table)))

;; from memoize.el @ http://nullprogram.com/blog/2010/07/26/
(defun tabbar-memoize (func)
  "Memoize FUNC.
If argument is a symbol then install the tabbar-memoized function over
the original function.  Use frame-local memoization."
  (typecase func
    (symbol (fset func (tabbar-memoize-wrap-frame-local (symbol-function func))) func)
    (function (tabbar-memoize-wrap-frame-local func))))

(defun tabbar-memoize-wrap-frame-local (func)
  "Return the tabbar-memoized version of FUNC.  The memoization cache is
frame-local."
  (let ((cache-sym (gensym))
        (val-sym (gensym))
        (args-sym (gensym)))
    `(lambda (&rest ,args-sym)
       ,(concat (documentation func) "\n(tabbar-memoized function)")
       (let* ((,cache-sym (tabbar-create-or-get-tabbar-cache))
              (,val-sym (gethash ,args-sym ,cache-sym)))
         (if ,val-sym
             ,val-sym
           (puthash ,args-sym (apply ,func ,args-sym) ,cache-sym))))))

(defun tabbar-ruler-tab-separator-image (face1 face2 &optional face3 next-on-top slope height)
  "Creates a Tabbar Ruler Separator Image.
FACE1 is the face to the left
FACE2 is the face to the right
FACE3 is the background face (optional)

When FACE1 is nil and FACE2 is present this function creates the
first tab image.

When FACE2 is nil and FACE1 is present this function creates the
last tab image.

When FACE1 = FACE2, this creates a non-selected separator

When FACE1 does not equal FACE2, this creates a selected separator
"
  (let* ((h (or height (max 17 (frame-char-height))))
         (m (or slope 1.7))
         (w (/ h m))
         (i h)
         x1 x2 e1 e2 e3 e4
         (color1 (if face1 (tabbar-hex-color (face-attribute face1 :background)) "None"))
         (color1-border (if face1 (tabbar-hex-color (face-attribute face1 :foreground)) "None"))
         (color2 (if face2 (tabbar-hex-color (face-attribute face2 :background)) "None"))
         (color2-border (if face2 (tabbar-hex-color (face-attribute face2 :foreground)) "None"))
         (color-background (if face3 (tabbar-hex-color (face-attribute face3 :background)) "None"))
         (ret "/* XPM */\nstatic char * "))
    (cond
     ((string= color1 color2)
      (setq ret (concat ret "tabbar_ruler_default_separator")))
     ((not face2)
      (setq ret (concat ret "tabbar_ruler_separator_end")))
     (t
      (setq ret (concat ret "tabbar_ruler_separator_end_sel"))))
    (setq ret (concat ret "[] = {\n"))
    (setq ret (format "%s\"%s %s 5 1\",\n" ret (round w) (- h 1)))
    ;; Now do colors
    (setq ret (format "%s\"  c %s\",\n" ret color-background))
    (setq ret (format "%s\". c  %s\",\n" ret color1))
    (setq ret (format "%s\"> c %s\",\n" ret color1-border))
    (setq ret (format "%s\"= c %s\",\n" ret color2))
    (setq ret (format "%s\"+ c %s\"" ret color2-border))
    (while (>= i 1)
      (setq x1 (round (+ 1 (/ (- i 1) m))))
      (setq x2 (round (/ (- (+ h m) i) m)))
      (cond
       ((and face2 (>= x1 x2))
        (if (= x2 1)
            (setq e1 "")
          (setq e1 (make-string (- x2 1) (if (not face1)?  ?.))))
        (if (= x1 x2)
            (progn
              (if (or next-on-top (not face1))
                  (setq e2 "+")
                (setq e2 ">"))
              (setq e3 "")
              (setq e4 ""))
          (if face1
              (setq e2 ">")
            (setq e2 ""))
          (setq e3 (make-string (- x1 x2) ? ))
          (setq e4 "+"))
        (if (= x1 w)
            (setq e5 "")
          (setq e5 (make-string (- (round w) x1) ?=))))
       ((or (and face1 (not face2))
            (and (< x1 x2) (not (or next-on-top (not face1)))))
        (if (= x2 1)
            (setq e1 "")
          (setq e1 (make-string (- x2 1) ?.)))
        (setq e2 ">")
        (setq e3 "")
        (setq e4 "")
        (if (= x2 w)
            (setq e5 "")
          (setq e5 (make-string (- (round w) x2) (if (not face2) ?  ?=)))))
       ((and (< x1 x2) (or next-on-top (not face1)))
        (if (= x1 1)
            (setq e1 "")
          (setq e1 (make-string (- x1 1) (if (not face1) ?  ?.))))
        (setq e2 "+")
        (setq e3 "")
        (setq e4 "")
        (if (= x1 w)
            (setq e5 "")
          (setq e5 (make-string (- (round w) x1) ?=)))))
      (setq ret (format "%s,\n\"%s%s%s%s%s\"" ret e1 e2 e3 e4 e5))
      (setq i (- i 1)))
    (setq ret (format "%s};" ret))
    (symbol-value 'ret)))


(defun* tabbar-ruler-image (&key type disabled color)
  "Returns the scroll-images"
  (let ((clr2 (if disabled (tabbar-hex-color (face-attribute 'mode-line-inactive :background))
                (tabbar-hex-color (face-attribute 'mode-line :background))))
        (clr (or color (if disabled (tabbar-hex-color (face-attribute 'mode-line-inactive :foreground))
                         (tabbar-hex-color (face-attribute 'mode-line :foreground))))))
    (if (eq type 'close)
        (format "/* XPM */
        static char * close_tab_xpm[] = {
        \"14 11 3 1\",
        \"       c None\",
        \".      c %s\",
        \"+      c %s\",
        \"     .....    \",
        \"    .......   \",
        \"   .........  \",
        \"  ... ... ... \",
        \"  .... . .... \",
        \"  ..... ..... \",
        \"  .... . .... \",
        \"  ... ... ... \",
        \"   .........  \",
        \"    .......   \",
        \"     .....    \"};" clr clr2)
      
      (format
       "/* XPM */
static char * scroll_%s_%s_xpm[] = {
\"17 17 2 1\",
\"       c None\",
\".      c %s\",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
%s
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \"};
" (symbol-name type)
(if disabled "disabled" "enabled")
clr
(cond
 ((eq 'right type)
  "\"                 \",
\"     ..          \",
\"     ....        \",
\"     ......      \",
\"     .....       \",
\"     ...         \",
"
  )
 ((eq 'left type)
  "\"                 \",
\"          ..     \",
\"        ....     \",
\"      ......     \",
\"       .....     \",
\"         ...     \","
  )
 ((eq 'up type)
  "\"        .        \",
\"       ..        \",
\"       ...       \",
\"      ....       \",
\"      .....      \",
\"      .....      \",")
 ((eq 'down type)
  "\"      .....      \",
\"      .....      \",
\"      ....       \",
\"       ...       \",
\"       ..        \",
\"        .        \","))))))


(defconst tabbar-home-button-enabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'down)))
  "Default image for the enabled home button.")

(defconst tabbar-home-button-disabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'up)))
  "Default image for the disabled home button")


(defconst tabbar-home-button
  (cons (cons "[o]" tabbar-home-button-enabled-image)
            (cons "[x]" tabbar-home-button-disabled-image)))

(setq tabbar-buffer-home-button
      (cons (cons "[+]" tabbar-home-button-enabled-image)
            (cons "[-]" tabbar-home-button-disabled-image)))

(setq tabbar-scroll-left-button-enabled-image
      `((:type xpm :data ,(tabbar-ruler-image :type 'left))))

(setq tabbar-scroll-left-button-disabled-image
      `((:type xpm :data ,(tabbar-ruler-image :type 'left :disabled t))))

(setq tabbar-scroll-left-button
      (cons (cons " <" tabbar-scroll-left-button-enabled-image)
            (cons " =" tabbar-scroll-left-button-disabled-image)))

(setq tabbar-scroll-right-button-enabled-image
      `((:type xpm :data ,(tabbar-ruler-image :type 'right))))

(setq tabbar-scroll-right-button-disabled-image
      `((:type xpm :data  ,(tabbar-ruler-image :type 'right :disabled t))))

(setq tabbar-scroll-right-button
      (cons (cons " >" tabbar-scroll-right-button-enabled-image)
            (cons " =" tabbar-scroll-right-button-disabled-image)))

(defsubst tabbar-normalize-image (image &optional margin nomask)
  "Make IMAGE centered and transparent.
If optional MARGIN is non-nil, it must be a number of pixels to add as
an extra margin around the image.  If optional NOMASK is non-nil, no mask
property is included."
  (let ((plist (cdr image)))
    (or (plist-get plist :ascent)
        (setq plist (plist-put plist :ascent 'center)))
    (or (plist-get plist :mask)
        (unless nomask
          (setq plist (plist-put plist :mask '(heuristic t)))))
    (or (not (natnump margin))
        (plist-get plist :margin)
        (plist-put plist :margin margin))
    (setcdr image plist))
  image)

(defvar tabbar-close-tab-function nil
  "Function to call to close a tabbar tab.  Passed a single argument, the tab
construct to be closed.")

(defvar tabbar-new-tab-function nil
  "Function to call to create a new buffer in tabbar-mode.  Optional single
argument is the MODE for the new buffer.")

;; for buffer tabs, use the usual command to close/kill a buffer
(defun tabbar-buffer-close-tab (tab)
  (let ((buffer (tabbar-tab-value tab)))
    (with-current-buffer buffer
      (kill-buffer buffer))))

(setq tabbar-close-tab-function 'tabbar-buffer-close-tab)

(defvar tabbar-last-tab nil)

(defsubst tabbar-click-on-tab (tab &optional type action)
  "Handle a mouse click event on tab TAB.
Call `tabbar-select-tab-function' with the received, or simulated
mouse click event, and TAB.
Optional argument TYPE is a mouse click event type (see the function
`tabbar-make-mouse-event' for details)."
  (let* ((mouse-event (tabbar-make-mouse-event type))
         (mouse-button (event-basic-type mouse-event)))
    (if  (eq mouse-button 'mouse-3)
        (progn
          (setq tabbar-last-tab tab)
          (tabbar-context-menu))
      (if (eq action 'close-tab)
          (when (and (eq mouse-button 'mouse-1) tabbar-close-tab-function)
            (funcall tabbar-close-tab-function tab))
        (when tabbar-select-tab-function
          (funcall tabbar-select-tab-function
                   (tabbar-make-mouse-event type) tab)
          (tabbar-display-update))))))

(defun tabbar-reset ()
  "Reset memoized functions."
  (interactive)
  (tabbar-memoize 'tabbar-ruler-tab-separator-image)
  (tabbar-memoize 'tabbar-ruler-image))
(tabbar-reset)


(defun tabbar-select-tab-callback (event)
  "Handle a mouse EVENT on a tab.
Pass mouse click events on a tab to `tabbar-click-on-tab'."
  (interactive "@e")
  (when (tabbar-click-p event)
    (let ((target (posn-string (event-start event))))
      (tabbar-click-on-tab
       (get-text-property (cdr target) 'tabbar-tab (car target))
       event
       (get-text-property (cdr target) 'tabbar-action (car target))))))

(defsubst tabbar-line-tab (tab &optional not-last sel)
  "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
  (let* ( (selected-p (tabbar-selected-p tab (tabbar-current-tabset)))
          (modified-p (buffer-modified-p (tabbar-tab-value tab)))
          (close-button-image (tabbar-find-image 
                               `((:type xpm :data ,(tabbar-ruler-image :type 'close :disabled (not modified-p)
                                                                       :color (if (eq tab sel)
                                                                                  (face-attribute 'default :foreground)
                                                                                "gray10"))))))
          (separator-image (tabbar-find-image
                            `((:type xpm :data
                                     ,(tabbar-ruler-tab-separator-image
                                       (if (eq tab sel)
                                           'tabbar-selected
                                         'tabbar-unselected)
                                       (if not-last
                                           (if (eq (car not-last) sel)
                                               'tabbar-selected
                                             'tabbar-unselected) nil)
                                       nil
                                       (if (and not-last
                                                (eq (car not-last) sel))
                                           t nil))))))
          (face (if selected-p
                    (if modified-p
                        'tabbar-selected-modified
                      'tabbar-selected)
                  (if modified-p
                      'tabbar-unselected-modified
                    'tabbar-unselected))))
    (concat
     (propertize " " 'face face
                 'tabbar-tab tab
                 'local-map (tabbar-make-tab-keymap tab)
                 'help-echo 'tabbar-help-on-tab
                 'face face
                 'pointer 'hand)
     (propertize 
      (if tabbar-tab-label-function
          (funcall tabbar-tab-label-function tab)
        tab)
      'tabbar-tab tab
      'local-map (tabbar-make-tab-keymap tab)
      'help-echo 'tabbar-help-on-tab
      'mouse-face 'tabbar-highlight
      'face face
      'pointer 'hand)
     (propertize (if modified-p
                     (with-temp-buffer
                       (ucs-insert "207A")
                       (insert " ")
                       (buffer-substring (point-min) (point-max))) " ")
                 'face face
                 'tabbar-tab tab
                 'local-map (tabbar-make-tab-keymap tab)
                 'help-echo 'tabbar-help-on-tab
                 'face face
                 'pointer 'hand)
     (propertize "[x]"
                 'display (tabbar-normalize-image close-button-image 0)
                 'face face
                 'pointer 'hand
                 'tabbar-tab tab
                 'local-map (tabbar-make-tab-keymap tab)
                 'tabbar-action 'close-tab)
     (propertize "|"
                 'display (tabbar-normalize-image separator-image)))))

(defsubst tabbar-line-format (tabset)
  "Return the `header-line-format' value to display TABSET."
  (let* ((sel (tabbar-selected-tab tabset))
         (tabs (tabbar-view tabset))
         (padcolor (tabbar-background-color))
         atsel elts
         (separator-image (tabbar-find-image
                           `((:type xpm :data
                                    ,(tabbar-ruler-tab-separator-image
                                      nil
                                      (if (eq (car tabs) sel)
                                          'tabbar-selected
                                        'tabbar-unselected)))))))
    ;; Initialize buttons and separator values.
    (or tabbar-separator-value
        (tabbar-line-separator))
    (or tabbar-home-button-value
        (tabbar-line-button 'home))
    (or tabbar-scroll-left-button-value
        (tabbar-line-button 'scroll-left))
    (or tabbar-scroll-right-button-value
        (tabbar-line-button 'scroll-right))
    ;; Track the selected tab to ensure it is always visible.
    (when tabbar--track-selected
      (while (not (memq sel tabs))
        (tabbar-scroll tabset -1)
        (setq tabs (tabbar-view tabset)))
      (while (and tabs (not atsel))
        (setq elts  (cons (tabbar-line-tab (car tabs) (cdr tabs) sel) elts)
              atsel (eq (car tabs) sel)
              tabs  (cdr tabs)))
      (setq elts (nreverse elts))
      ;; At this point the selected tab is the last elt in ELTS.
      ;; Scroll TABSET and ELTS until the selected tab becomes
      ;; visible.
      (with-temp-buffer
        (let ((truncate-partial-width-windows nil)
              (inhibit-modification-hooks t)
              deactivate-mark ;; Prevent deactivation of the mark!
              start)
          (setq truncate-lines nil
                buffer-undo-list t)
          (apply 'insert (tabbar-line-buttons tabset))
          (setq start (point))
          (while (and (cdr elts) ;; Always show the selected tab!
                      (progn
                        (delete-region start (point-max))
                        (goto-char (point-max))
                        (apply 'insert elts)
                        (goto-char (point-min))
                        (> (vertical-motion 1) 0)))
            (tabbar-scroll tabset 1)
            (setq elts (cdr elts)))))
      (setq elts (nreverse elts))
      (setq tabbar--track-selected nil))
    ;; Format remaining tabs.
    (while tabs
      (setq elts (cons (tabbar-line-tab (car tabs) (cdr tabs) sel) elts)
            tabs (cdr tabs)))
    ;; Cache and return the new tab bar.
    (tabbar-set-template
     tabset
     (list (tabbar-line-buttons tabset)
           (propertize "|"
                       'display (tabbar-normalize-image separator-image))
           (nreverse elts)
           (propertize "%-"
                       'face (list :background padcolor
                                   :foreground padcolor)
                       'pointer 'arrow)))
    ))

(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :weight bold))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :weight bold))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-key-binding '((t
                               :foreground "white"))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)



(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :weight bold))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :weight bold
     ))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-key-binding '((t
                               :foreground "white"))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)

;; Hooks based on yswzing's hooks, but modified for this function state.
;; called each time the modification state of the buffer changed
(defun tabbar-ruler-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))

;; first-change-hook is called BEFORE the change is made
(defun tabbar-ruler-on-buffer-modification ()
  (set-buffer-modified-p t)
  (tabbar-ruler-modification-state-change))
(add-hook 'after-save-hook 'tabbar-ruler-modification-state-change)

(defcustom tabbar-ruler-global-tabbar 't
  "* Should tabbar-ruler have a global tabbar?"
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-global-ruler nil
  "* Should tabbar-ruler have a global ruler?"
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-menu nil
  "* Should tabbar-ruler have a popup menu.  As mouse moves toward top of window, the menu pops up."
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-toolbar nil
  "* Should tabbar-ruler have a popup toolbar.  As mouse moves toward top of window, the toolbar pops up."
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-menu-min-y 5 ;
  "* Minimum number of pixels from the top before a menu/toolbar pops up."
  :type 'integer
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-menu-min-y-leave 50
  "* Minimum number of pixels form the top before a menu/toolbar disappears."
  :type 'integer
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-do-not-switch-on-ruler-when-tabbar-is-on-y 75
  "* Minimum number of pixels to switch on ruler when tabbar is on."
  :type 'integer          
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-excluded-buffers '("*Messages*" "*Completions*" "*ESS*")
  "* Excluded buffers in tabbar."
  :type '(repeat (string :tag "Buffer Name"))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-fight-igore-modes '(info-mode helm-mode package-menu-mode)
  "Exclude these mode when changing between tabbar and ruler."
  :type '(repeat (symbol :tag "Major Mode")))

(defvar tabbar-ruler-tabbar-off 't)
(defvar tabbar-ruler-ruler-off 't)
(set (make-variable-buffer-local 'tabbar-ruler-toolbar-off) nil)
(set (make-variable-buffer-local 'tabbar-ruler-ruler-off) nil)

(defvar tabbar-ruler-toolbar-off nil)
(defvar tabbar-ruler-menu-off nil)
(add-hook 'find-file-hook (lambda() (interactive) (tabbar-ruler-tabbar-ruler-fight 't)))
(defcustom tabbar-ruler-ruler-display-commands '(ac-trigger-commands
                                                 esn-upcase-char-self-insert
                                                 esn-magic-$
                                                 right-char
                                                 left-char
                                                 previous-line
                                                 next-line
                                                 backward-paragraph
                                                 forward-paragraph
                                                 cua-scroll-down
                                                 cua-scroll-up
                                                 cua-paste
                                                 cua-paste-pop
                                                 autopair-newline
                                                 autopair-insert-opening
                                                 autopair-skip-close-maybe
                                                 autopair-backspace
                                                 backward-delete-char-untabify
                                                 delete-backward-char
                                                 self-insert-command)
  "* Ruler display commands."
  :group 'tabbar-ruler
  :type '(repeat symbol))

(defun tabbar-ruler-tabbar-ruler-fight (&optional initialize)
  "* Defines the fighting behavior of the tabbar-ruler ruler and tabbar."
  (condition-case error
      (progn
        (cond
         ((minibufferp)
           nil)
         ((and (save-match-data (string-match "^[*]Org Src " (buffer-name))))
          nil)
         ((member major-mode tabbar-ruler-fight-igore-modes)
          nil)
         ( (eq major-mode 'helm-mode)
           nil)
         ( (eq last-command 'mouse-drag-region)
           (tabbar-ruler-mouse-movement))
         ( (and tabbar-ruler-global-ruler tabbar-ruler-global-tabbar)
           (cond
            
            ( (memq last-command tabbar-ruler-ruler-display-commands)
              (when tabbar-ruler-ruler-off
                (ruler-mode 1)
                (setq tabbar-ruler-ruler-off nil))
              (unless tabbar-ruler-tabbar-off
                (tabbar-mode -1)
                (setq tabbar-ruler-tabbar-off 't))
              (when tabbar-ruler-popup-menu
                (unless tabbar-ruler-menu-off
                  (unless (eq system-type 'darwin)
		    (menu-bar-mode -1))
                  (setq tabbar-ruler-menu-off 't)))
              (when tabbar-ruler-popup-toolbar
                (unless (eq system-type 'darwin)
                  (unless tabbar-ruler-toolbar-off
                    (tool-bar-mode -1)
                    (setq tabbar-ruler-toolbar-off 't)))))
            ( (save-match-data (string-match "\\(mouse\\|ignore\\|window\\|frame\\)" (format "%s" last-command)))
              (when nil ;; Took this out;  Afterward it works much better...
                (unless tabbar-ruler-ruler-off
                  (ruler-mode -1)
                  (setq tabbar-ruler-ruler-off 't))
                (when tabbar-ruler-tabbar-off
                  (tabbar-mode 1)
                  (setq tabbar-ruler-tabbar-off nil))))
            ( 't
              (when (or initialize (and tabbar-ruler-ruler-off tabbar-ruler-tabbar-off))
                (when tabbar-ruler-ruler-off
                  (ruler-mode 1)
                  (setq tabbar-ruler-ruler-off nil))
                (unless tabbar-ruler-tabbar-off
                  (tabbar-mode -1)
                  (setq tabbar-ruler-tabbar-off 't))))))
         ( tabbar-ruler-global-ruler
           (when tabbar-ruler-ruler-off
             (ruler-mode 1)
             (setq tabbar-ruler-ruler-off nil)))
         ( tabbar-ruler-global-tabbar
           (when tabbar-ruler-tabbar-off
             (tabbar-mode 1)
             (setq tabbar-ruler-tabbar-off nil)))))
    (error
     (message "Error in post-command-hook for Ruler/Tabbar: %s" (error-message-string error)))))

(add-hook 'post-command-hook 'tabbar-ruler-tabbar-ruler-fight)
(defvar tabbar-ruler-movement-timer nil)
(defvar tabbar-ruler-movement-x nil)
(defvar tabbar-ruler-movement-y nil)

(defun tabbar-ruler-mouse-movement ()
  "* Mouse Movement function"
  (interactive)
  (when tabbar-ruler-movement-timer
    (cancel-timer tabbar-ruler-movement-timer))
  (let* ((y-pos (cddr (mouse-pixel-position)))
         (x-pos (cadr (mouse-pixel-position))))
    (unless y-pos
      (setq y-pos tabbar-ruler-movement-y))
    (unless x-pos
      (setq x-pos tabbar-ruler-movement-x))
    (when (or (not tabbar-ruler-movement-x) (not tabbar-ruler-movement-y)
              (and tabbar-ruler-movement-x tabbar-ruler-movement-y
                   (not
                    (and
                     (= tabbar-ruler-movement-x x-pos)
                     (= tabbar-ruler-movement-y y-pos)))))
      (when (and x-pos y-pos)
        (setq tabbar-ruler-movement-x x-pos)
        (setq tabbar-ruler-movement-y y-pos)
        (unless tabbar-ruler-ruler-off
          (ruler-mode -1)
          (setq tabbar-ruler-ruler-off 't))
        (when tabbar-ruler-tabbar-off
          (tabbar-mode 1)
          (setq tabbar-ruler-tabbar-off nil))
        (if (>= (if (or tabbar-ruler-menu-off tabbar-ruler-toolbar-off)
                    tabbar-ruler-popup-menu-min-y
                  tabbar-ruler-popup-menu-min-y-leave) y-pos)
            (progn
              (when tabbar-ruler-popup-menu
                (when tabbar-ruler-menu-off
                  (unless (eq system-type 'darwin)
		    (menu-bar-mode 1))
                  (setq tabbar-ruler-menu-off nil)))
              (when tabbar-ruler-popup-toolbar
                (unless (eq system-type 'darwin)
                  (when tabbar-ruler-toolbar-off
                    (tool-bar-mode 1)
                    (setq tabbar-ruler-toolbar-off nil)))))
          (when tabbar-ruler-popup-menu
            (unless tabbar-ruler-menu-off
              (unless (eq system-type 'darwin)
		(menu-bar-mode -1))
              (setq tabbar-ruler-menu-off 't)))
          (when tabbar-ruler-popup-toolbar
            (unless (eq system-type 'darwin)
              (unless tabbar-ruler-toolbar-off
                (tool-bar-mode -1)
                (setq tabbar-ruler-toolbar-off 't)))))))
    (setq tabbar-ruler-movement-timer (run-with-timer
                                       0.01
                                       nil
                                       'tabbar-ruler-mouse-movement))))
(tabbar-ruler-mouse-movement)


(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

(defun last-tabbar-ruler-tabbar-buffer-groups nil)

(defun tabbar-ruler-tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (setq last-tabbar-ruler-tabbar-buffer-groups
        (list
         (cond
          ;;          ((or (get-buffer-process (current-buffer))
          ;;               ;; Check if the major mode derives from `comint-mode' or
          ;;               ;; `compilation-mode'.
          ;;               (tabbar-buffer-mode-derived-p
          ;;                major-mode '(comint-mode compilation-mode)))
          ;;           "Process")
          ;;    ((string-match "^ *[*]" (buffer-name))
          ;;     "Common"
          ;;     )
          ((eq major-mode 'dired-mode)
           "Dired")
          ((memq major-mode
                 '(help-mode apropos-mode Info-mode Man-mode))
           "Help")
          ((memq major-mode
                 '(rmail-mode
                   rmail-edit-mode vm-summary-mode vm-mode mail-mode
                   mh-letter-mode mh-show-mode mh-folder-mode
                   gnus-summary-mode message-mode gnus-group-mode
                   gnus-article-mode score-mode gnus-browse-killed-mode))
           "Mail")
          (t
           "Files"
           ))))
  (symbol-value 'last-tabbar-ruler-tabbar-buffer-groups))
(setq tabbar-buffer-groups-function 'tabbar-ruler-tabbar-buffer-groups)

(defun tabbar-ruler-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or *, when they are not
visiting a file.  The current buffer is always included."
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((member (buffer-name b) tabbar-ruler-excluded-buffers) nil)
                     ;; ((string= "*Messages*" (format "%s" (buffer-name b))))
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ;;((char-equal ?* (aref (buffer-name b) 0)) nil)
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'tabbar-ruler-tabbar-buffer-list)
(provide 'tabbar-ruler)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tabbar-ruler.el ends here
