(context "Conditionals"
  (context "(if <test> <consequent> <alternate>)"
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
  (context "(and <test1> ...)"
    (assert "returns #t if both tests evaluate to #t"
            (= #t (and (= 2 2) (= 5 5))))
    (pending "returns #t if there are no <test>s")
    (pending "returns the last <test> if no <test>s are #f")
  )
  (context "(not <obj>)"
    (assert "returns #t if <obj> is #f"
            (not #f))
    (assert "returns #f if <obj> is #t"
            (not (not #t)))
    (assert "returns #f for any <obj> not #f"
            (not (and (not 10)
                      (not 'a))))
  )
)
