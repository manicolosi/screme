require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Special Form: Let" do
  it "works with one binding" do
    input = '(let ((a 5)) (* a 2))'
    evaluate(input).should == 10
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
