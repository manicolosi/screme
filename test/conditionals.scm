(context "Conditionals"
  (context "and"
    (assert "returns #t if both tests evaluate to #t"
            (= #t (and (= 2 2) (= 5 5))))
  )
  (context "not"
    (assert "returns #t if argument is #f"
            (not #f))
    (assert "returns #f if argument is #t"
            (not (not #t)))
    (assert "returns #f for any other argument not #f"
            (not (and (not 10)
                      (not 'a))))
  )
  (context "if"
    (assert "evaluates <consequent> when <test> is a true value"
            (= 10
               (if (= 5 (+ 2 3))
                      10
                      'failed)))
    (assert "evaluates <alternate> when <test> is NOT a true value"
            (= 10
               (if (= 6 (+ 2 3))
                      'failed
                      10)))
    (pending "<consequent> and <alternate> are never both evaluated")
    (pending "result is unspecified when <test> is #f and there is no <alternate>")
  )
)
