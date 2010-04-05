require File.dirname(__FILE__) + '/../lib/screme.rb'

Pair = Screme::Runtime::Pair

describe "Pair" do
  before do
    @pair = Pair.new :a, :b
  end
  specify "set and retrieve car and cdr" do
    @pair.car.should == :a
    @pair.cdr.should == :b
  end

  specify "can initialize from an Array" do
    @pair = Pair.list [:a, :b]
    @pair.car.should == :a
    @pair.cdr.car.should == :b
    @pair.cdr.cdr.should == nil
  end

  specify "can convert back to an array" do
    @pair = Pair.list [:a, :b, :c]
    @pair.to_a.should == [:a, :b, :c]
  end

  specify "should implement equality" do
    Pair.new(:a, :b).should == Pair.new(:a, :b)
    Pair.new(:a, :b).should_not == Pair.new(:c, :d)
  end

  specify "external representation should look like a Lisp list" do
    @pair.scm_inspect.should == '(a . b)'
  end
end
