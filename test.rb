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

  def test_variable
    assert_equal 3, parse("x").eval({'x' => 3})
  end
end
