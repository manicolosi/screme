$: << File.dirname(__FILE__)

require 'forwardable'

%w[ ast environment extensions function syntax inspectors
    parser/parser runtime ].each do |file|
  require file
end

module Screme
  class Interpreter

    attr_reader :env


    extend Forwardable
    def_delegators :@env, :define, :define_special

    def initialize
      @env = Environment.new
      @parser = Parser.new

      @env.load(Runtime::Primitives)
    end

    def parse_and_eval(input)
      @parser.parse(input).evaluate(@env)
    end
  end
end
