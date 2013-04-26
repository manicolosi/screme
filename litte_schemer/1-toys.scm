(context "Atoms"
  (assert "`atom' is an atom"
          (atom? 'atom))

  (assert "`turkey' is an atom"
          (atom? 'turkey))

  (assert "`1492' is an atom"
          (atom? 1492))

  (assert "`*abc$' is an atom"
          (atom? '*abc$)))

(context "Lists"
  (define list? (lambda (lst)
    (pair? lst)))

  (assert "`(atom)' is a list"
          (list? '(atom)))

  (assert "`(atom turkey or)' is a list"
          (list? '(atom turkey or))))

