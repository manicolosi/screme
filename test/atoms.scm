(context "Atoms"
  (assert "symbols are atoms"
          (atom? 'a))
  (assert "strings are atoms"
          (atom? "abc"))
  (assert "booleans are atoms"
          (atom? #t)
          (atom? #f))
  (assert "lists are NOT atoms"
          (not (atom? '(a b c))))
)
