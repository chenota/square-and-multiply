#! /usr/bin/env -S sbcl --script

;; Main sam function
(defun sam (a b n)
    ;; Do reduction on bits to get answer
    (reverse (reduce
        ;; Reduction function
        (lambda (fc bit) 
            (cons (cons (mod (* (caar fc) (caar fc) (if bit a 1)) n) 
                        (+ (* 2 (cdar fc)) (if bit 1 0))) 
                  fc))
        ;; Sequence of bits of exponent b
        (reverse (loop for i below (integer-length b) collect (logbitp i b)))
        ;; Start off with f=1, c=0
        :initial-value (list (cons 1 0)))))

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
                          (progn (format t "c~Cf~%" #\tab)
                                 (loop for x in sam-result do 
                                    (format t "~D~C~D~%" (cdr x) #\tab (car x))))
                          (format t "~D~%" (caar sam-result)))))))
