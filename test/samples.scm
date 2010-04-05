(context "Unit Test Samples"
  (context "Nested Contexts"
    (assert "A passing assertion"
            (= 3 (+ 1 2)))
    (assert "A failing assertion"
            (= 3 (* 1 2)))
    (assert "A pending assertion")
    (assert "An exceptional assertion"
            (unbound '(unbound is unbound so it causes an error)))
  )
)
