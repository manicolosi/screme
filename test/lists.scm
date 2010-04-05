(context "Lists"
  (context "Pairs: (cons <obj1> <obj2>), (car <pair>), and (cdr <pair>)"
    (assert "the empty list is null"
            (null? '()))
    (assert "the empty list is NOT a pair"
            (not (pair? '())))
    (assert "atoms and pairs are NOT null"
            (not (null? 'a))
            (not (null? 42)))
            (not (null? (cons 'a 'b)))
    (assert "atoms are NOT pairs"
            (not (pair? 'a))
            (not (pair? 42)))
    (assert "(cons <obj1> <obj2>) constructs a pair"
            (pair? (cons 'a 'b)))
    (assert "(car <pair>) retrieves the car of a pair"
            (= 'a (car (cons 'a 'b)))
            (= 1 (car '(1 2))))
    (assert "(cdr <pair>) retrieves the cdr of a pair"
            (= 'b (cdr (cons 'a 'b)))
            (= '(2) (cdr '(1 2))))
  )
)
