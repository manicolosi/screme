$: << File.dirname(__FILE__)

require 'forwardable'

%w[ ast environment function parser syntax ].each do |file|
  require file
end

class ScremeInterpreter
  extend Forwardable

  attr_reader :env

  def initialize
    @env = Environment.new
    @parser = Parser.new

    # This all should be kept in a different file
    define_syntax(:define) do |env, identifier, expression|
      env.define identifier, expression.evaluate(env)
    end

    define_syntax(:lambda) do |env, formals, body|
      Function.lambda(env, formals, body)
    end

    define(:+) {|a, b| a + b}
    define(:*) {|a, b| a * b}

    # For debugging. env needs to be a syntax, so it can get at the
    # environment.
    define_syntax(:env) {|env| env}
    define(:pp) {|arg| pp arg}
  end

  def parse_and_eval(input)
    @parser.parse(input).evaluate(@env)
  end

  private

  def_delegators :@env, :define, :define_syntax
end
