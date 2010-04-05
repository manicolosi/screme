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

  specify "external representation should look like a Lisp list" do
    @pair.scm_inspect.should == '(a . b)'
  end

  specify "can initialize from an Array" do
    pending
    @pair = Cons.from_a [:a, :b]
  end
end
