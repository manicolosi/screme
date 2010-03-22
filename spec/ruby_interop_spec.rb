require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Ruby Interop" do
  specify "symbols starting with # call that method on the first argument" do
    input = '(#split "a string into pieces")'
    evaluate(input).should == ["a", "string", "into", "pieces"]
  end

  specify "other arguments are passed to the function" do
    input = '(#join \'(put back together again) " ")'
    evaluate(input).should == "put back together again"
  end

  def evaluate(input)
    ScremeInterpreter.new.parse_and_eval(input)
  end
end
