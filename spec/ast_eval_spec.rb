require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "AST" do
  it "should be able to evaluate integers" do
    ast = 123
    ast.evaluate.should == 123
  end

  it "should be able to evaluate strings" do
    ast = 'abc'
    ast.evaluate.should == 'abc'
  end

  it "should be able to evaluate symbols" do
    ast = :x
    env = { :x => 5 }
    ast.evaluate(env).should == 5
  end

  it "should take an optional environment for self-evaluating expressions" do
    env = {}
    123.evaluate(env).should == 123
    'abc'.evaluate(env).should == 'abc'
  end

  it "should raise an error when symbol is undefined" do
    lambda { :x.evaluate }.should raise_error
  end

  it "should apply the function inside of a list" do
    env = {:+ => lambda {|env, a, b| a + b} }
    ast = [:+, 2, 3]
    ast.evaluate(env).should == 5
  end

  it "should evaluate arguments before applying a function" do
    env = {:+ => lambda {|env, a, b| a.evaluate(env) + b.evaluate(env)} }
    ast = [:+, [:+, 2, 4], [:+, 1, 3]]
    ast.evaluate(env).should == 10
  end
end
