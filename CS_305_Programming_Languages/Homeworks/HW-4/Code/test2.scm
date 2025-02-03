(define example-program
  '(
    ;; Declarations
    (("input" input1 input2)
     ("node" node1 node2)
     ("input" input1 input2)
     ("output" output1 output2)
     ("node" output1 output2)
     ("node" node2 node1 input1))

    ;; Assignments
    ((node1 = input3 or (not input4))
     (node2 = node1 and input2)
     (output1 = input1 and node2)
     (output2 = node4 or node2)
     (output3 = (node8 xor input2) and (not input3)))

    ;; Evaluation
    (("evaluate" circuit1 ((input1 true) (input2 true)))
     ("evaluate" circuit2 ((input2 false) (input3 false)))
     ("evaluate" circuit3 ((input2 true) (input1 false)))
     ("evaluate" circuit4 ((input2 false) (input4 true))))
  ))


