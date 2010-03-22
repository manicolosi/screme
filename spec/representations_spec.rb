require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Representation" do
  specify "integers are represented as themselves" do
    4.representation.should == '4'
  end

  specify "identifiers are represented as themselves" do
    :xyz.representation.should == 'xyz'
  end

  specify "lists are enclosed in parentheses and separated by spaces" do
    [1, 2, 3].representation.should == '(1 2 3)'
  end

  specify "lists show the representation of their elements" do
    [1, :x, "test"].representation.should == '(1 x "test")'
  end

  specify "strings are enclosed in quotation marks" do
    "a test string".representation.should == '"a test string"'
    'a "test" string'.representation.should == '"a \"test\" string"'
  end

  specify "rationals have a slash separating the numerator and denominator" do
    Rational(3, 4).representation.should == "3/4"
  end
end
