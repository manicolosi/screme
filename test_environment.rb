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

    assert_equal 7, @env[:+].apply(@env, a, b)
  end
end
