require 'test/unit'
require 'mocha'

lib_path = File.dirname(__FILE__) + '/../lib/'
require lib_path + 'environment'

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

  def test_parent_bound?_checking
    parent = @env
    child = Environment.new parent

    parent.define :x, 3
    parent.define :y, 5
    child.define :y, 7 # Shadow parent's :y

    assert child.bound?(:y)
    assert child.bound?(:x)
  end

  def test_parent_lookup
    parent = @env
    child = Environment.new parent

    parent.define :x, 3
    parent.define :y, 5
    child.define :y, 7 # Shadow parent's :y

    assert_equal 7, child[:y]
    assert_equal 3, child[:x]
  end

  def test_syntax
    @env.define_syntax(:test) {}

    assert @env[:test].is_a? Syntax
  end

  def test_bindings
    parent = @env
    child = Environment.new parent

    parent.define :x, 3
    parent.define :y, 5
    child.define :z, 7

    bindings = child.bindings

    assert_equal 3, bindings.length
    assert bindings.include?(:x)
    assert bindings.include?(:y)
    assert bindings.include?(:z)
  end
end
