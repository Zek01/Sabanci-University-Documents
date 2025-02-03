(define example-program
  '(
    ;; Declarations
    (("input" input1 input2)
     ("output" output1 output2)
     ("node" node1 node2 node4 node3)
     ("input" input3))

    ;; Assignments
    ((node1 = input1 or (not input2))
     (node2 = node1 and input2)
     (output1 = input1 and node2)
     (output2 = node1 or node2))

    ;; Evaluation
    (("evaluate" circuit3 ((input1 true) (input2 true)))
     ("evaluate" circuit2 ((input2 true) (input1 false) (input3 true)))
     ("evaluate" circuit1 ((input2 false) (input2 true) (input3 false)))
    )
))


