(defun http-char (char1 char2 &optional (default #\Space))
  (let ((code (parse-integer
                (coerce (list char1 char2) 'string)
                :radix 16
                :junk-allowed t)))
    (if code
      (code-char code)
      default)))


(defun decode-param (my-string)
  (labels ((my-fun (my-list)
                   (when my-list
                     (case (car my-list)
                       (#\% (cons (http-char (cadr my-list) (caddr my-list))
                                  (my-fun (cdddr my-list))))
                       (#\+ (cons #\space (my-fun (cdr my-list))))
                       (otherwise (cons (car my-list) (my-fun (cdr my-list))))))))
    (coerce (my-fun (coerce my-string 'list)) 'string)))


(defun parse-params (my-string)
  (let* ((index1 (position #\= my-string))
         (index2 (position #\& my-string)))
    (cond (index1 (cons (cons (intern (string-upcase (subseq my-string 0 index1)))
                              (decode-param (subseq my-string (1+ index1) index2)))
                        (and index2 (parse-params (subseq my-string (1+ index2))))))
          ((equal my-string "") nil)
          (t my-string))))

(defun parse-url (s)
  (let* ((url (subseq s
                      (+ 2 (position #\space s))
                      (position #\space s :from-end t)))
         (x (position #\? url)))
    (if x
      (cons (subseq url 0 x) (parse-params (subseq url (1+ x))))
      (cons url '()))))

(defun get-header (stream)
  (let* ((s (read-line stream))
         (h (let ((i (position #\: s)))
              (when i
                (cons (intern (string-upcase (subseq s 0 i)))
                      (subseq s (+ i 2)))))))
    (when h
      (cons h (get-header stream)))))


(defun get-content-params (stream header)
  (let ((length (cdr (assoc 'content-length header))))
    (when length
      (let ((content (make-string (parse-integer length))))
        (read-sequence content stream)
        (parse-params content)))))


(defun serve (request-handler)
  (let ((socket (socket-server 8080)))
    (unwind-protect
      (loop (with-open-stream (stream (socket-accept socket))
              (let* ((url (parse-url (read-line stream)))
                     (path (car url))
                     (header (get-header stream))
                     (params (append (cdr url)
                                     (get-content-params stream header)))
                     (*standard-output* stream))
                (funcall request-handler path header params))))
      (socket-server-close socket))))


(defun hello-request-handler (path header params)
  (if (equal path "greeting")
    (let ((name (assoc 'name params)))
      (if (not name)
        (princ "<html><form>What is your name?<input name='name' /></form></html>")
        (format t "<html>Nice to meet you, ~a!</html>" (cdr name))))
    (princ "Sorry, I don't know that page.")))

(serve #'hello-request-handler)
