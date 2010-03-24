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
)
