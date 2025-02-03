; Helper function to extract declarations
(define get-declarations
  (lambda (lcd)
    (car lcd)))

; Helper function to extract assignments
(define get-assignments
  (lambda (lcd)
    (cadr lcd)))

; Helper function to extract evaluations
(define get-evaluations
  (lambda (lcd)
    (caddr lcd)))

; Helper function to collect typed identifiers
(define collect-typed-ids
  (lambda (declarations)
    (let* ((inputs '())
           (outputs '())
           (nodes '()))
      (for-each
       (lambda (decl)
         (cond ((equal? (car decl) "input") (set! inputs (append inputs (cdr decl))))
               ((equal? (car decl) "output") (set! outputs (append outputs (cdr decl))))
               ((equal? (car decl) "node") (set! nodes (append nodes (cdr decl))))))
       declarations)
      (list inputs outputs nodes))))

; Helper function to collect identifiers from an assignment
(define collect-ids-from-assign
  (lambda (assignment)
    (if (list? assignment)
        (let ((lhs (car assignment))             ; Left-hand side
              (rhs (cdr (cdr assignment))))      ; Skip '=' symbol
          (append (list lhs) (collect-symbols-from-expr rhs))) ; Combine lhs and symbols in rhs
        '())))

;; List of logical operators to exclude for the function find-undeclared-identifiers
(define logical-operators '(or and not xor))

;; Helper function to collect symbols from an expression
(define collect-symbols-from-expr
  (lambda (expr)
    (cond ((null? expr) '())                     ; Base case: empty list
          ((list? expr)                          ; If list, recursively process elements
           (append (collect-symbols-from-expr (car expr))
                   (collect-symbols-from-expr (cdr expr))))
          ((and (symbol? expr)                   ; If symbol and not a logical operator
                (not (member expr logical-operators)))
           (list expr))                          ; Wrap valid symbols in a list
          (else '()))))                          ; Ignore non-symbols and operators

;; Helper to find duplicates while preserving the order of first duplicate occurrence
(define count-duplicates
  (lambda (ids)
    (let loop ((remaining ids)
               (seen '())
               (duplicates '()))
      (if (null? remaining)
          (reverse duplicates) ;; Return duplicates in the correct order
          (let ((current (car remaining)))
            (if (member current seen)
                (if (not (member current duplicates))
                    (loop (cdr remaining) (cons current seen) (cons current duplicates)) ; Add to duplicates
                    (loop (cdr remaining) (cons current seen) duplicates)) ; Skip already recorded duplicates
                (loop (cdr remaining) (cons current seen) duplicates)))))))
				
;; Helper function to collect identifiers from an evaluation 
(define collect-ids-from-eval
  (lambda (evaluation)
    (let ((assignments (caddr evaluation)))      ; Extract assignments part
      (apply append (map (lambda (assignment)
                           (if (list? assignment)
                               (list (car assignment)) ; Only collect symbols on lhs
                               '()))
                         assignments)))))
						


; Debugging: Helper to ensure all items in a list are valid for append solve the append error
(define ensure-list
  (lambda (item)
    (cond ((list? item) item)    ; If already a list, return as-is
          ((symbol? item) (list item)) ; Wrap single symbols in a list
          (else '()))))          ; Otherwise, return an empty list

; find-undeclared-identifiers => Implement Rule 1
(define find-undeclared-identifiers
  (lambda (lcd)
    (let* ((declarations (ensure-list (car lcd)))  ;declarations
           (assignments (ensure-list (cadr lcd)))  ;assignments
           (evaluations (ensure-list (caddr lcd))) ;evaluations
           ; Collect declared identifiers
           (declared-ids (apply append
                                (map (lambda (decl)
                                       (ensure-list (cdr decl)))
                                     declarations)))
           ; Collect used identifiers from assignments and evaluations
           (used-assignments (apply append
                                    (map collect-ids-from-assign assignments)))
           (used-evaluations (apply append
                                    (map collect-ids-from-eval evaluations)))
           ; Combine all used identifiers
           (used-ids (append used-assignments used-evaluations)))
      ; Filter and return undeclared identifiers in the order they appear
      (filter (lambda (id)
                (and (symbol? id) (not (member id declared-ids))))
              used-ids))))


;; find-multiple-declarations => Implement Rule 2
(define find-multiple-declarations
  (lambda (lcd)
    (let* ((decls (apply append (map cdr (get-declarations lcd))))) ; Flatten all declared identifiers
      ; Handle duplicates and ensure all occurrences are captured
      (let ((duplicates (count-duplicates decls)))
        ; Add the last occurrence explicitly if it's a duplicate
        (if (and (not (null? decls))
                 (member (car (reverse decls)) duplicates))
            (append duplicates (list (car (reverse decls)))) ; Add the last duplicate explicitly
            duplicates)))))


; check-identifier-usage => Implement Rule 3, 4, 5
(define check-identifier-usage
  (lambda (lcd)
    (let* ((decls (collect-typed-ids (get-declarations lcd))) ; Collect typed declarations
           (inputs (car decls))                              ; Extract inputs
           (outputs (cadr decls))                            ; Extract outputs
           (nodes (caddr decls))                             ; Extract nodes
           (assignments (get-assignments lcd))               ; Get all assignments
           (all-assigned (map car assignments))              ; Collect all LHS of assignments
           (used (apply append (map collect-ids-from-assign assignments))) ; All used identifiers
           ; Find unused inputs
           (unused-inputs (filter (lambda (x) (not (member x used))) inputs))
           ; Find unassigned nodes and outputs
           (unassigned-nodes-outputs
            (filter (lambda (x) (not (member x all-assigned)))
                    (append outputs nodes)))
           ; Find multi-assigned identifiers (inputs, nodes, outputs)
           (multi-assigned-nodes-outputs
            (filter (lambda (x)
                      (> (count (lambda (y) (equal? x y)) all-assigned) 1))
                    (append inputs outputs nodes)))) ; Include inputs in multi-assignment check
      ; Return results
      (list unused-inputs unassigned-nodes-outputs multi-assigned-nodes-outputs))))

; check-inputs-in-evaluation => Implement Rule 6, 7
(define check-inputs-in-evaluation
  (lambda (lcd)
    (let* ((decls (collect-typed-ids (get-declarations lcd))) ; Collect declared identifiers
           (inputs (car decls)) ; Extract inputs
           (evaluations (get-evaluations lcd)) ; Extract evaluations
           (unassigned-inputs '()) ; List for unassigned inputs
           (multi-assigned-inputs '())) ; List for multiple assigned inputs
      (for-each
       (lambda (eval)
         (let* ((eval-name (cadr eval)) ; Correctly extract evaluation name
                (assignments (caddr eval)) ; Extract input assignments in this evaluation
                (assigned-ids (map car assignments)) ; Collect assigned IDs
                ; Find unassigned inputs
                (unassigned (filter (lambda (id) (not (member id assigned-ids))) inputs))
                ; Find inputs with multiple assignments
                (multi-assigned (filter (lambda (id)
                                          (> (count (lambda (x) (equal? x id)) assigned-ids) 1))
                                        assigned-ids)))
           ; Add evaluation name to unassigned or multi-assigned inputs if applicable
           (if (not (null? unassigned))
               (set! unassigned-inputs (cons eval-name unassigned-inputs)))
           (if (not (null? multi-assigned))
               (set! multi-assigned-inputs (cons eval-name multi-assigned-inputs))))) ; Fix multi-assigned
       evaluations)
      (list (reverse unassigned-inputs) (reverse multi-assigned-inputs))))) ; Reverse lists to preserve order


; check-incorrect-assignments => Implement Rule 8, 9
(define check-incorrect-assignments
  (lambda (lcd)
    (let* ((decls (collect-typed-ids (get-declarations lcd)))
           (inputs (car decls))
           (outputs (cadr decls))
           (nodes (caddr decls))
           (assignments (get-assignments lcd))
           (evaluations (get-evaluations lcd))
           (invalid-input-assignments
            (filter (lambda (asg)
                      (and (list? asg)
                           (member (car asg) inputs)))
                    assignments))
           (invalid-node-output-assignments
            (apply append
                   (map (lambda (eval)
                          (filter (lambda (id)
                                    (member id (append nodes outputs)))
                                  (map car (caddr eval))))
                        evaluations))))
      (list (map car invalid-input-assignments) invalid-node-output-assignments))))

