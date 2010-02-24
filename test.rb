require 'test/unit'
require 'treetop'

Treetop.load 'grammar.tt'

class TestCase < Test::Unit::TestCase
  def setup
    @parser = SchemeParser.new
  end

  def parse(str)
    @parser.parse(str)
  end

  def test_integer
    assert_equal 0, parse("0").eval
    assert_equal 5, parse("5").eval
    assert_equal 123, parse("123").eval
  end

  def test_string
    assert_equal 'basic string', parse('"basic string"').eval

    assert_equal 'Testing inside quotes: "',
      parse('"Testing inside quotes: \""').eval

    assert_equal "Hitch Hiker's Guide to the Galaxy",
      parse('hhgttg').eval({'hhgttg' => "Hitch Hiker's Guide to the Galaxy"})
  end

  def test_identifier
    assert_equal 3, parse("x").eval({'x' => 3})
  end

  def test_identifiers_cant_contain_parenthesis
    assert_nil parse("a(c")
    assert_nil parse("a)c")
  end

  def test_whitespace
    assert_equal 123, parse(" 123 ").eval
    assert_equal 3, parse(" x ").eval({'x' => 3})
  end

  def test_multiple_expressions_return_the_last_expression_evaluated
    assert_equal 3, parse("1 2 3").eval
  end

  def test_lists_are_recognized
    assert_not_nil parse("(a b c)")
  end

  def test_lists_are_evaluated
    @env = { '+' => proc {|a, b| a + b}, 'b' => 1, 'c' => 2 }
    assert_equal 3, parse("(+ b c)").eval(@env)
  end
end
