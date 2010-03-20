require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Special Form: Let" do
  it "works with one binding" do
    input = '(let ((a 5)) (* a 2))'
    evaluate(input).should == 10
  end

  it "works with multiple bindings" do
    input = '(let ((a 5) (b 10) (c 2)) (+ (* a c) b))'
    evaluate(input).should == 20
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
