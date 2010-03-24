(context "Quotation"
  (context "(quote <datum>)"
    (assert "quoting a self-evaluating atom is equal to that atom"
            (and (= 10 (quote 10))
                 (= "string" (quote "string"))))
    (assert "quoting a symbol prevents evaluation"
            (not (= 10 (let ((x 10))
                         (quote x)))))
    (assert "(quote <datum>) may be abbreviated '<datum>"
            (= 'a (quote a)))
    (assert "can quote a list to make a list and prevent function application"
            (= '(a b c) (quote (a b c))))
    (assert "quotes can be nested to prevent further quote evaluation"
            (= '(quote (quote a)) '''a))
  )
)
