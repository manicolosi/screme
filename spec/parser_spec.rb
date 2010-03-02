require File.dirname(__FILE__) + '/../lib/parser.rb'

describe Parser do
  it "should parse integer atom expressions as Ruby integers" do
    input = '123'
    parse(input).should == 123
  end

  it "should parse string atom expressions as Ruby strings" do
    input = '"Hello world"'
    parse(input).should == "Hello world"
  end

  it "should parse symbol atom expressions as Ruby symbols" do
    input = 'abc'
    parse(input).should == :abc
  end

  it "should parse a list of integers as a Ruby list of Ruby integers" do
    input = '(123 456 789)'
    parse(input).should == [123, 456, 789]
  end

  it "should parse a list of integers, strings, and symbols" do
    input = '(1 "two" three)'
    parse(input).should == [1, "two", :three]
  end

  def parse(input)
    Parser.new.parse(input)
  end
end
