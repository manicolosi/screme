$: << File.dirname(__FILE__)

require 'forwardable'

%w[ ast environment extensions function parser syntax
    representations runtime/primitives ].each do |file|
  require file
end

class ScremeInterpreter

  attr_reader :env


  extend Forwardable
  def_delegators :@env, :define, :define_special

  def initialize
    @env = Environment.new
    @parser = Parser.new

    @env.load(Primitives)
  end

  def parse_and_eval(input)
    @parser.parse(input).evaluate(@env)
  end
end
