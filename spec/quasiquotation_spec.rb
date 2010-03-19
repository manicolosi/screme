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

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
