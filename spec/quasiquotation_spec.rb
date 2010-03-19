require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Quasiquotation" do
  it "should work like normal quotation" do
    input = '(quasiquote a)'
    evaluate(input).should == :a

    input = '(quasiquote (a b c))'
    evaluate(input).should == [:a, :b, :c]
  end

  it "should work like normal quotation (backquote)" do
    input = '`a'
    evaluate(input).should == :a

    input = '`(a b c)'
    evaluate(input).should == [:a, :b, :c]
  end

  it "should allow quasiquoting quotes" do
    input = "(quasiquote '(a b c))"
    evaluate(input).should == [:quote, [:a, :b, :c]]
  end

  it "should allow quoting quasiquotes" do
    input = "(quote `(a b c))"
    evaluate(input).should == [:quasiquote, [:a, :b, :c]]
  end

  it "should allow unquoting single atoms" do
    interpreter = ScremeInterpreter.new
    interpreter.env.define(:a, 5)

    input = "(quasiquote (unquote a))"
    evaluate(input, interpreter).should == 5
  end

  it "should allow unquoting single atoms (backquote and comma)" do
    interpreter = ScremeInterpreter.new
    interpreter.env.define(:a, 5)

    input = "`,a"
    evaluate(input, interpreter).should == 5
  end

  it "should allow unquoting single atoms in a list" do
    pending

    interpreter = ScremeInterpreter.new
    interpreter.env.define(:b, 2)

    input = "(quasiquote (a (unquote b) c))"
    evaluate(input, interpreter).should == [:a, 2, :c]
  end

  def evaluate(input, interpreter = ScremeInterpreter.new)
    interpreter.parse_and_eval(input)
  end
end
