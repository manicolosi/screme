require File.dirname(__FILE__) + '/../lib/screme.rb'

describe Parser do
  it "should parse integer atom expressions as Ruby integers" do
    input = '123'
    parse(input).should == 123
  end

  it "should parse string atom expressions as Ruby strings" do
    input = '"Hello world"'
    parse(input).should == "Hello world"
  end

  it "should be able to parse strings containing escaped quotes" do
    input = '"Hello \"World\""'
    parse(input).should == 'Hello "World"'
  end

  it "should be able to parse strings containing escaped backslashes" do
    input = '"Hello \\\\ World"'
    parse(input).should == 'Hello \\ World'
  end

  it "should parse symbol atom expressions as Ruby symbols" do
    input = 'abc'
    parse(input).should == :abc
  end

  it "should parse a list of integers as a Ruby list of Ruby integers" do
    input = '(123 456 789)'
    parse(input).should == [123, 456, 789]
  end

  it "should parse #t and #f booleans to the Ruby boolean types" do
    input = '#t'
    parse(input).should == true

    input = '#f'
    parse(input).should == false

    input = '(#t #f #t)'
    parse(input).should == [true, false, true]
  end

  it "should not parse identifiers beginning with #t and #f as #t and #f" do
    input = '(#fast-food #taco-bell)'
    parse(input).should == [:"#fast-food", :"#taco-bell"]
  end

  it "should parse a list of integers, strings, and symbols" do
    input = '(1 "two" three)'
    parse(input).should == [1, "two", :three]
  end

  it "should be able to parse the quote character before atoms" do
    input = "'1"
    parse(input).should == [:quote, 1]

    input = "'abc"
    parse(input).should == [:quote, :abc]

    input = '\'"abc"'
    parse(input).should == [:quote, "abc"]
  end

  it "should be able to parse the quote character before lists" do
    input = "'(a 1 b 2 c 3)"
    parse(input).should == [:quote, [:a, 1, :b, 2, :c, 3]]
  end

  def parse(input)
    Parser.new.parse(input)
  end
end
