require File.dirname(__FILE__) + '/../lib/environment.rb'

describe Environment do
  it "can define a variable" do
    env = Environment.new

    env.should_not be_bound(:x)

    env.define :x, 5

    env.should be_bound(:x)
    env[:x].should == 5
  end

  it "can define a variable as a function with a block" do
    env = Environment.new

    env.define(:+) do |x, y|
      x + y
    end

    env[:+].call(env, 3, 4).should == 7
  end

  it "will check parent environment for a binding" do
    parent = Environment.new
    child  = Environment.new(parent)

    parent.define :x, 3
    parent.define :y, 5
    child.define  :y, 7 # Shadow parent's :y

    child.should be_bound(:x)
    child.should be_bound(:y)

    child[:x].should == 3
    child[:y].should == 7
  end

  it "can have a special form defined" do
    env = Environment.new

    env.define_special(:test) do |env2, expr1, expr2|
      env.should == env2
      expr1.should == [:peanut, :butter]
      expr2.should == :jelly
      :retval
    end

    env[:test].call(env, [:peanut, :butter], :jelly).should == :retval
  end

  it "has a Hash of all bindings" do
    parent = Environment.new
    child  = Environment.new(parent)

    parent.define :x, 3
    parent.define :y, 5
    child.define  :z, 7

    bindings = child.bindings

    bindings.length.should == 3

    bindings.should include(:x)
    bindings.should include(:y)
    bindings.should include(:z)

    bindings[:x].should == 3
    bindings[:y].should == 5
    bindings[:z].should == 7
  end

  it "can't be modified through #bindings" do
    env = Environment.new
    env.define :x, 1

    bindings = env.bindings

    bindings[:x] = 2

    env[:x].should == 1
    bindings[:x].should == 2
  end

  it "can have another environment merged in" do
    env1 = Environment.new
    env2 = Environment.new

    env1.define :x, 1
    env2.define :y, 1

    env1.should_not be_bound(:y)

    env1.merge env2

    env1.should be_bound(:y)
  end

  it "can have a module of functions loaded into it" do
    pending
  end
end
