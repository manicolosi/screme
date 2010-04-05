(context "Atoms"
  (assert "symbols are atoms"
          (atom? 'a))
  (assert "strings are atoms"
          (atom? "abc"))
  (assert "booleans are atoms"
          (atom? #t)
          (atom? #f))
  (assert "the empty list is NOT an atom"
          (not (atom? '())))
  ;; Doesn't work yet, because '(a b c) doesn't cons cells
  (assert "lists are NOT atoms"
          (not (atom? '(a b c))))
)
