;; graphviz stuff
(defparameter *max-label-length* 30)

(defun dot-name (expression)
  (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string expression)))

(defun dot-label (expression)
  (if expression
    (let ((my-string (write-to-string expression :pretty nil)))
      (if (> (length my-string) *max-label-length*)
        (concatenate 'string (subseq my-string 0 (- *max-label-length* 3)) "...")
        my-string))
    ""))

(defun nodes->dot (nodes)
  (mapc (lambda (node)
          (fresh-line)
          (princ (dot-name (car node)))
          (princ "[label=\"")
          (princ (dot-label node))
          (princ "\"];"))
        nodes))

(defun edges->dot (edges)
  (mapc (lambda (node)
          (mapc (lambda (edge)
                  (fresh-line)
                  (princ (dot-name (car node)))
                  (princ "->")
                  (princ (dot-name (car edge)))
                  (princ "[label=\"")
                  (princ (dot-label (cdr edge)))
                  (princ "\"];"))
                (cdr node)))
        edges))

(defun graph->dot (nodes edges)
  (princ "digraph{")
  (nodes->dot nodes)
  (edges->dot edges)
  (princ "}"))

(defun dot->png (file-name thunk)
  (with-open-file (*standard-output*
                    file-name
                    :direction :output
                    :if-exists :supersede)
    (funcall thunk))
  (ext:shell (concatenate 'string "dot -Tpng -O " file-name)))

(defun graph->png (file-name nodes edges)
  (dot->png file-name
            (lambda ()
              (graph->dot nodes edges))))

(defun uedges->dot (edges)
   (maplist (lambda (lst)
               (mapc (lambda (edge)
                      (unless (assoc (car edge) (cdr lst))
                         (fresh-line)
                         (princ (dot-name (caar lst)))
                         (princ "--")
                         (princ (dot-name (car edge)))
                         (princ "[label=\"")
                         (princ (dot-label (cdr edge)))
                         (princ "\"];")))
                     (cdar lst)))
             edges))

 (defun ugraph->dot (nodes edges)
   (princ "graph{")
    (nodes->dot nodes)
    (uedges->dot edges)
    (princ "}"))

 (defun ugraph->png (file-name nodes edges)
    (dot->png file-name
              (lambda ()
                (ugraph->dot nodes edges))))
