(define example-program
  '(
    ;; Declarations
    (("input" input1 input2 input3)
     ("node" node1 node2)
     ("output" output1 output2))

    ;; Assignments
    ((node1 = input1 or (not input2))
     (node2 = node1 and input2)
     (input2 = node1 or  node2)
     (input1 = node2 and (not node1))
     (input2 = node2 and (not node1))
     (output1 = input1 and node2)
     (output2 = (node1 xor input2) and (not node2)))

    ;; Evaluation
    (("evaluate" circuit1 ((output2 false) (input2 false) (node1 false)))
     ("evaluate" circuit2 ((input2 true) (node2 false) (output1 true)))
    )
))


