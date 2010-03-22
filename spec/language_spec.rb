require File.dirname(__FILE__) + '/../lib/parser.rb'

describe "Language" do
  describe "(if conditional)" do
    it "should evaluate the first s-exp when condition is #t" do
      input = '(if #t "true" "false")'
      evaluate(input).should == 'true'
    end

    it "should evaluate the second s-exp when condition is #f" do
      input = '(if #f "true" "false")'
      evaluate(input).should == 'false'
    end

    it "should not evaluate both expressions" do
      pending "Need to implement let and set! first"
    end
  end

  describe "(booleans)" do
    it "should follow Scheme's idea of true and false"
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
