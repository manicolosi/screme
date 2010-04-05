require File.dirname(__FILE__) + '/../lib/screme.rb'

describe "Inspectors" do
  specify "integers are represented as themselves" do
    4.scm_inspect.should == '4'
  end

  specify "true and false are represented as #t and #f" do
    true.scm_inspect.should == '#t'
    false.scm_inspect.should == '#f'
  end

  specify "identifiers are represented as themselves" do
    :xyz.scm_inspect.should == 'xyz'
  end

  specify "lists are enclosed in parentheses and separated by spaces" do
    [1, 2, 3].scm_inspect.should == '(1 2 3)'
  end

  specify "lists show the representation of their elements" do
    [1, :x, "test"].scm_inspect.should == '(1 x "test")'
  end

  specify "strings are enclosed in quotation marks" do
    "a test string".scm_inspect.should == '"a test string"'
    'a "test" string'.scm_inspect.should == '"a \"test\" string"'
  end

  specify "rationals have a slash separating the numerator and denominator" do
    Rational(3, 4).scm_inspect.should == "3/4"
  end

  specify "the empty list is represented by '()'" do
    nil.scm_inspect.should == '()'
  end
end
