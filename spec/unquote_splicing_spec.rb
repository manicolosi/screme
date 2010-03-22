require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "unquote-splicing" do
  it "a quoted list" do
    input = "`(1 (unquote-splicing '(2 3 4)) 5)"
    evaluate(input).should == [1, 2, 3, 4, 5]
  end

  it "a quoted list (comma-at)" do
    input = "`(1 ,@'(2 3 4) 5)"
    evaluate(input).should == [1, 2, 3, 4, 5]
  end

  it "a bound variable" do
    interpreter = ScremeInterpreter.new
    interpreter.env.define(:b, [2, 3, 4])

    input = "`(1 (unquote-splicing b) 5)"
    evaluate(input, interpreter).should == [1, 2, 3, 4, 5]
  end

  it "a bound variable (comma-at)" do
    interpreter = ScremeInterpreter.new
    interpreter.env.define(:b, [2, 3, 4])

    input = "`(1 ,@b 5)"
    evaluate(input, interpreter).should == [1, 2, 3, 4, 5]
  end

  it "nested deeply" do
    input = "`(5 (7 (unquote-splicing '(2 5)) 13) 15)"
    evaluate(input).should == [5, [7, 2, 5, 13], 15]
  end

  def evaluate(input, interpreter = ScremeInterpreter.new)
    interpreter.parse_and_eval(input)
  end
end
