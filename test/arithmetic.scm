(context "Arithmetic"
  (context "Numeric Equality (=)"
    (assert "returns #t when all arguments are numerically equal"
            (= (+ 2 3) (+ 4 1)))
    (assert "works with any number of arguments"
            (= 5 5 5))
    (assert "returns #f otherwise"
            (not (= 5 4)))
  )
  (context "Addition (+)"
    (assert "with no operands returns the additive identity"
            (= 0 (+)))
    (assert "adds any number of operands"
            (= 7 (+ 3 4))
            (= 18 (+ 3 4 5 6)))
  )
  (context "Subtraction (-)"
    (assert "with no arguments raises an error")
    (assert "with one operand returns the additive inverse"
            (= -3 (- 3)))
    (assert "works with any number of operands"
            (= -1 (- 3 4))
            (= -6 (- 3 4 5)))
  )
  (context "Multiplication (*)"
    (assert "with no arguments returns the multiplicative identity"
            (= 1 (*)))
    (assert "with one operand returns the operand"
            (= 3 (* 3)))
    (assert "multiplies any number of operands"
            (= 12 (* 3 4))
            (= 60 (* 3 4 5)))
  )
  (context "Division (/)"
    (assert "with one operand returns the multiplicative inverse"
            (= (rational 1 3) (/ 3)))
    (assert "works with any number of operands"
            (= (rational 3 4) (/ 3 4))
            (= (rational 3 20) (/ 3 4 5)))
  )
)
