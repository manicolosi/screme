$: << File.dirname(__FILE__)

require 'forwardable'

%w[ ast environment extensions inspectors
    applicable/function applicable/macro applicable/syntax
    parser/parser runtime/primitives ].each do |file|
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

      @env.load(Primitives)
    end

    def parse_and_eval(input)
      @parser.parse(input).evaluate(@env)
    end
  end
end
