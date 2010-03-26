(context "Atoms"
  (assert "symbols are atoms"
          (atom? 'a))
  (assert "strings are atoms"
          (atom? "abc"))
  (assert "lists are NOT atoms"
          (not (atom? '(a b c))))
)
