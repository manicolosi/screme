require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Type Predicates" do
  it "symbols are atoms" do
    input = "(atom? 'a)"
    evaluate(input).should be true
  end

  it "strings are atoms" do
    input = '(atom? "abc")'
    evaluate(input).should be true
  end

  it "numbers are atoms" do
    input = "(atom? 10)"
    evaluate(input).should be true
  end

  it "lists are NOT atoms" do
    input = "(atom? '(a b c))"
    evaluate(input).should be false
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
