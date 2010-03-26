(context "Quotation"
  (context "(quote <datum>)"
    (assert "quoting a self-evaluating atom is equal to that atom"
            (= 10 (quote 10))
            (= "string" (quote "string")))
    (assert "quoting a symbol prevents evaluation"
            (not (= 10 (let ((x 10))
                         (quote x)))))
    (assert "may be abbreviated '<datum>"
            (= 'a (quote a)))
    (assert "can quote a list to make a list and prevent function application"
            (= '(a b c) (quote (a b c))))
    (assert "quotes can be nested to prevent further quote evaluation"
            (= '(quote (quote a)) '''a))
  )
  (context "(quasiquote <qq template>)"
    (assert "works like normal quotation"
            (= 'a (quasiquote a))
            (= '(a b c) (quasiquote (a b c))))
    (assert "may be abbreviated `<qq template>"
            (= 'a `a)
            (= '(a b c) `(a b c)))
    (assert "(unquote <expr>) unquotes expressions inside quasiquotation"
            (= 5 (let ((a 5)) `(unquote a)))
            (= '(a 2 c) (let ((b 2)) `(a (unquote b) c)))
            (= '(list 3 4) `(list (unquote (+ 1 2)) 4)))
    (assert "(unquote <expr>) works when nested deeply"
            (= '(5 (7 10 13) 15)
               `(5 (7 ,(* 2 5) 13) 15)))
    (assert "(unquote <expr>) may be abbreviated ,<expr>"
            (= '(list 3 4) `(list ,(+ 1 2) 4)))
    (assert "(unquote-splicing <list>) inserts list into surround list"
            (= '(1 2 3 4 5)
               `(1 (unquote-splicing '(2 3 4)) 5)))
    (assert "(unquote-splicing <list>) may be abbreviated ,@<list>"
            (= '(1 2 3 4 5)
               `(1 ,@'(2 3 4) 5)))
    (assert "(unquote-splicing <list> works when nested deeply"
            (= '(5 (7 2 5 13) 15)
               `(5 (7 ,@'(2 5) 13) 15)))
  )
)
