require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Quotation" do
  it "should be able to quote single atoms" do
    interpreter = ScremeInterpreter.new
    input = '(quote a)'

    interpreter.parse_and_eval(input).should == :a
  end

  it "should be able to quote an entire list" do
    interpreter = ScremeInterpreter.new
    input = '(quote (a 1 b 2 c 3))'

    interpreter.parse_and_eval(input).should == [:a, 1, :b, 2, :c, 3]
  end

  it "should be able to use the apostrophe as a shortcut to quote" do
    pending

    interpreter = ScremeInterpreter.new
    input = "'(a 1 b 2 c 3)"

    interpreter.parse_and_eval(input).should == [:a, 1, :b, 2, :c, 3]
  end
end
