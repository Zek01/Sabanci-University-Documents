(define get-operator (lambda (op) 
	(cond 
	  ( (eq? op '+) +)
	  ( (eq? op '*) *)
	  ( (eq? op '-) -)
	  ( (eq? op '/) /)
	  ( else (error "s5: cannot handle operator --> " op)))))

(define s5 (lambda (e)
	 (cond 
	   ( (number? e) e )
	   ( (not (list? e))           (error "s5: cannot evaluate --> " e))
	   ( (not (> (length e) 0))    (error "s5: cannot evaluate --> " e))
	   ( else 
	       (let (
		     (operator (get-operator (car e)))
		     (operands (map s5 (cdr e)))
		    )
                      (apply operator operands))))))

(define repl (lambda ()
      (let* 
	 (
	  (dummy1 (display "cs305> "))
	  (expr (read))
	  (val (s5 expr))
	  (dummy2 (display "cs305: "))
	  (dummy3 (display val))
	  (dummy4 (newline))
	  (dummy5 (newline))
	 )
	 (repl))))
	
