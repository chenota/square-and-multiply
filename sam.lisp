#! /usr/bin/env -S sbcl --script

;; Main sam function
(defun sam (a b n)
    ;; Do reduction on bits to get answer
    (reverse (reduce
        ;; Reduction function
        (lambda (fc bit) 
            (cons (list (if bit #\1 #\0) 
                        (+ (* 2 (second (car fc))) (if bit 1 0))
                        (mod (* (third (car fc)) (third (car fc)) (if bit a 1)) n)) 
                  fc))
        ;; Sequence of bits of exponent b
        (reverse (loop for i below (integer-length b) collect (logbitp i b)))
        ;; Start off with f=1, c=0
        :initial-value (list (list #\- 0 1)))))

;; Run help or main program
(if (member "-h" *posix-argv* :test #'string-equal) 
    (format t "Usage: sam [-v] a b n")
    ;; Check for verbose argument
    (let ((verbose (member "-v" *posix-argv* :test #'string-equal))
           (args (reverse (reduce (lambda (args arg)
                                          (if (parse-integer arg :junk-allowed t)
                                              (cons (parse-integer arg) args)
                                              args))
                                  (cdr *posix-argv*)
                                  :initial-value nil))))
                 ;; Check number of integer arguments
          (progn (if (= 3 (length args)) 
                     () 
                     (progn (format t "Error: Expected integer arguments a, b, and n") 
                            (exit)))
                 ;; Print result
                 (let ((sam-result (apply #'sam args)))
                      (if verbose
                          (progn (format t "k~Cc~Cf~%" #\tab #\tab)
                                 (loop for x in sam-result do 
                                    (format t "~C~C~D~C~D~%" (first x) #\tab (second x) #\tab (third x))))
                          (format t "~D~%" (third (car (last sam-result)))))))))
