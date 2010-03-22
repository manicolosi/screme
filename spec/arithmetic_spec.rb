require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Arithmetic" do
  describe "Addition: +" do
    specify "with no operands returns the additive identity" do
      input = '(+)'
      evaluate(input).should == 0
    end

    specify "with one operand returns the operand" do
      input = '(+ 3)'
      evaluate(input).should == 3
    end

    specify "adds any number of operands" do
      input = '(+ 3 4)'
      evaluate(input).should == 7

      input = '(+ 3 4 5 6)'
      evaluate(input).should == 18
    end
  end

  describe "Subtraction: -" do
    specify "with no arguments raises an error" do
      pending "function arity checking"
    end

    specify "with one operand returns the additive inverse" do
      input = '(- 3)'
      evaluate(input).should == -3
    end

    specify "works with any number of operands" do
      input = '(- 3 4)'
      evaluate(input).should == -1

      input = '(- 3 4 5)'
      evaluate(input).should == -6
    end
  end

  describe "Multiplication: *" do
    specify "with no arguments returns the multiplicative identity" do
      input = '(*)'
      evaluate(input).should == 1
    end

    specify "with one operand returns the operand" do
      input = '(* 3)'
      evaluate(input).should == 3
    end

    specify "multiplies any number of operands" do
      input = '(* 3 4)'
      evaluate(input).should == 12

      input = '(* 3 4 5)'
      evaluate(input).should == 60
    end
  end

  describe "Division: /" do
    specify "with one operand returns the multiplicative inverse" do
      input = '(/ 3)'
      evaluate(input).should == Rational(1, 3)
    end

    specify "works with any number of operands" do
      input = '(/ 3 4)'
      evaluate(input).should == Rational(3, 4)

      input = '(/ 3 4 5)'
      evaluate(input).should == Rational(3, 20)
    end
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
