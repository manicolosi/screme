require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Special Form: Let" do
  it "works with one binding" do
    input = '(let ((a 5)) (* a 2))'
    evaluate(input).should == 10
  end

  it "works with multiple bindings" do
    input = %{
      (let ((x 2) (y 3))
        (* x y))
    }
    evaluate(input).should == 6
  end

  it "evaluates the bindings in the parent environment" do
    input = %{
      (let ((x 2) (y 3))
        (let ((x 7)
              (z (+ x y)))
          (* z x)))
    }

    evaluate(input).should == 35
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
