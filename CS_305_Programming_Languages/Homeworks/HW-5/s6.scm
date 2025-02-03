(define get-operator (lambda (op) 
	(cond 
	  ( (eq? op '+) +)
	  ( (eq? op '*) *)
	  ( (eq? op '-) -)
	  ( (eq? op '/) /)
	  ( else (error "s6: cannot handle operator --> " op)))))

(define define-statement? (lambda (e)
	(and 
	  (list? e)
	  (= (length e) 3)
	  (eq? (car e) 'define)
	  (symbol? (cadr e))
	)))

(define get-value (lambda (var env)
        (cond
	  ( (null? env) (error "s6: unbound variable --> " var) )
	  ( (eq? var (caar env)) (cdar env) )
	  ( else (get-value var (cdr env)) )
	)))

(define extend-env (lambda (var val old-env)
        (cons (cons var val) old-env)))

(define s6 (lambda (e env)
	 (cond 
	   ( (number? e) e )
	   ( (symbol? e) (get-value e env) )
	   ( (not (list? e))           (error "s6: cannot evaluate --> " e))
	   ( (not (> (length e) 0))    (error "s6: cannot evaluate --> " e))
	   ( else 
	       (let (
		     (operator (get-operator (car e)))
		     (operands (map s6 (cdr e) (make-list (length (cdr e)) env)))
		    )
                      (apply operator operands))))))

(define repl (lambda (env)
      (let* 
	 (
	  (dummy1 (display "cs305> "))
	  (expr (read))
	  (new-env (if (define-statement? expr)
		       (extend-env (cadr expr) (s6 (caddr expr) env) env) ; define
		       (if (let-statement? expr) 
			   env
		           env))
	  (
	  (val (if (define-statement? expr)
		   (cadr expr)
		   (s6 expr env)))
	  (dummy2 (display "cs305: "))
	  (dummy3 (display val))
	  (dummy4 (newline))
	  (dummy5 (newline))
	 )
	 (repl new-env))))
	
