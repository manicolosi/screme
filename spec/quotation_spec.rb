require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Quotation" do
  it "should be able to quote single atoms" do
    input = '(quote a)'
    evaluate(input).should == :a
  end

  it "should be able to quote single atoms (apostrophe)" do
    input = "'a"
    evaluate(input).should == :a
  end

  it "should be able to quote an entire list" do
    input = '(quote (a 1 b 2 c 3))'
    evaluate(input).should == [:a, 1, :b, 2, :c, 3]
  end

  it "should be able to quote an entire list (apostrophe)" do
    input = "'(a 1 b 2 c 3)"
    evaluate(input).should == [:a, 1, :b, 2, :c, 3]
  end

  it "should be able to quote a quoted expression" do
    input = '(quote (quote a))'
    evaluate(input).should == [:quote, :a]
  end

  it "should be able to quote a quoted expression (apostrophes)" do
    input = "''a"
    evaluate(input).should == [:quote, :a]
  end

  it "apostrophes can be nested deeply" do
    input = "'''''a"
    evaluate(input).should == [:quote, [:quote, [:quote, [:quote, :a]]]]
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
