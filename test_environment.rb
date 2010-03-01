require 'test/unit'
require 'mocha'

require 'environment'

class EnvironmentTestCase < Test::Unit::TestCase
  def setup
    @env = Environment.new
  end

  def test_define_a_variable
    assert ! @env.bound?(:x)

    @env.define :x, 5

    assert @env.bound? :x
    assert_equal 5, @env[:x]
  end

  def test_define_a_function
    @env.define(:+) do |a, b|
      a + b
    end

    a = stub :eval => 3
    b = stub :eval => 4

    assert @env[:+].is_a? Function
    assert_equal 7, @env[:+].apply(@env, a, b)
  end

  def test_environment_lookup
    parent = @env
    child = Environment.new parent

    parent.define :x, 3
    parent.define :y, 5
    child.define :y, 7 # Shadow parent's :y

    assert child.bound?(:y)
    assert child.bound?(:x)
  end

  def test_syntax
    @env.define_syntax(:test) {}

    assert @env[:test].is_a? Syntax
  end
end
