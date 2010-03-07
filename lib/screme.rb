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
    define_special(:define) do |env, identifier, expression|
      env.define identifier, expression.evaluate(env)
    end

    define_special(:lambda) do |env, formals, body|
      Function.lambda(env, formals, body)
    end

    define_special(:quote) do |env, expression|
      expression
    end

    define(:+) {|a, b| a + b}
    define(:*) {|a, b| a * b}

    # For debugging. env needs to be a syntax, so it can get at the
    # environment.
    define_special(:env) {|env| env}
    define(:pp) {|arg| pp arg}
  end

  def parse_and_eval(input)
    @parser.parse(input).evaluate(@env)
  end

  private

  def_delegators :@env, :define, :define_special
end
