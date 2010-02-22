class SimpleTestCase < TestCase
  def test_atoms
    assert 5, scheme_eval 5
    assert "hello", scheme_eval "hello"
  end

  def test_functions
    assert 5, scheme_eval [:+, 2, 3]
    assert 3, scheme_eval [:car, [:cdr, [:list, 2, 3]]]
  end
end
