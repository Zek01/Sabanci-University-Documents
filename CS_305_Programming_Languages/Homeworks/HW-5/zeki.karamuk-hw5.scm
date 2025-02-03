(define get-operator (lambda (op) 
  (cond 
    ((eq? op '+=) +)
    ((eq? op '*) *)
    ((eq? op '-) -)
    ((eq? op '/) /)
    ((eq? op '/=) (lambda (a b) (not (= a b))))
    (else (error "ERROR: Unsupported operator\n")))))

(define define-statement?
  (lambda (e)
    (and (list? e) 
         (= (length e) 3)
         (eq? (car e) 'define)
         (symbol? (cadr e))))) ; Ensure second element is a valid symbol

(define let-statement?
  (lambda (e)
    (and (list? e)
         (= (length e) 3)
         (list? (cadr e)) 
         (every (lambda (binding)
                  (and (list? binding)
                       (= (length binding) 2)
                       (symbol? (car binding))))
                (cadr e)))))

(define lambda-statement? (lambda (e)
  (and (list? e) (= (length e) 3) (eq? (car e) 'lambda) (list? (cadr e)))))

(define get-value
  (lambda (var env)
    (cond
      ((null? env) 'ERROR)  ; Return ERROR
      ((eq? var (caar env)) (cdar env))
      (else (get-value var (cdr env))))))

(define extend-env (lambda (var val env)
  (let ((existing-binding (assoc var env)))
    (if existing-binding
        ;; Update the value of the existing binding
        (cons (cons var val) (remove (lambda (pair) (eq? (car pair) var)) env))
        ;; Add a new binding
        (cons (cons var val) env)))))

(define eval-let
  (lambda (bindings body env)
    (if (not (and (list? bindings)
                  (every (lambda (binding)
                           (and (list? binding)
                                (= (length binding) 2)
                                (symbol? (car binding))))
                         bindings)))
        "ERROR"  ;; Invalid bindings
        (let ((new-env env))
          (for-each (lambda (binding)
                      (let ((var (car binding))
                            (val (eval-expr (cadr binding) env)))
                        (if (equal? val "ERROR")
                            (set! new-env "ERROR")
                            (set! new-env (extend-env var val new-env)))))
                    bindings)
          ;; If an error occurred during binding evaluation, return "ERROR"
          (if (equal? new-env "ERROR")
              "ERROR"
              (eval-expr body new-env))))))

(define eval-lambda
  (lambda (params body env)
    (lambda args
      (if (not (= (length params) (length args)))
          (error "ERROR: Incorrect argument count")
          (let ((extended-env (append (map cons params args) env)))
            (eval-expr body extended-env))))))

(define eval-expr
  (lambda (e env)
    (cond
      ;; Case 1: Number literals
      ((number? e) e)

      ;; Case 2: Symbol (variable lookup)
      ((symbol? e)
       (let ((value (get-value e env)))
         (if (equal? value "ERROR") "ERROR" value)))

      ;; Case 3: Define statement
      ((define-statement? e)
       (if (symbol? (cadr e))
           (let ((val (eval-expr (caddr e) env)))
             (if (equal? val "ERROR")
                 "ERROR"
                 (cadr e)))  ;; Return the variable name
           "ERROR"))

      ;; Case 4: Let statement
      ((let-statement? e)
       (let ((bindings (cadr e))
             (body (caddr e)))
         (eval-let bindings body env)))

      ;; Case 5: Lambda statement
      ((lambda-statement? e)
       (if (and (list? (cadr e)) (list? (caddr e)))
           (eval-lambda (cadr e) (caddr e) env)
           "ERROR"))

      ;; Case 6: Function application
      ((list? e)
       (let* ((operator (eval-expr (car e) env))
              (operands (map (lambda (arg) (eval-expr arg env)) (cdr e))))
         (if (or (equal? operator "ERROR") (member "ERROR" operands))
             "ERROR"
             (if (procedure? operator)
                 (apply operator operands)
                 "ERROR"))))

      ;; Case 7: Invalid expression
      (else "ERROR"))))

(define cs305
  (lambda ()
    (let loop ((env (list (cons '/= (lambda (a b) (not (= a b))))
                         (cons '+ +)
                         (cons '- -)
                         (cons '* *)
                         (cons '/ /))))
      (display "cs305> ")
      (let ((expr (read)))
        (let* ((new-env (if (define-statement? expr)
                            (extend-env (cadr expr) (eval-expr (caddr expr) env) env)
                            env))
               (val (if (define-statement? expr)
                        (cadr expr)
                        (eval-expr expr env))))
          (display "cs305: ")
          (if (eq? val 'ERROR)
              (display "ERROR")
              (if (procedure? val)
                  (display "[PROCEDURE]")
                  (display val)))
          (newline)
          (newline)
          (loop new-env))))))
