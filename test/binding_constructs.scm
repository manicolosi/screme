(context "Binding Constructs"
  (context "let"
    (assert "binds a variable"
            (= 10
               (let ((a 5)) (* a 2))))
    (assert "binds multiple variable"
            (= 6
               (let ((x 2) (y 3))
                 (* x y))))
    (assert "evaluates <body> in a new environment"
            (and (define x 1)
                 (= 6
                    (let ((x 2) (y 3))
                      (* x y)))))
    (assert "evaluates <bindings> in the parent environment"
            (= 35
               (let ((x 2) (y 3))
                 (let ((x 7) (z (+ x y)))
                   (* x z)))))
  )
)
