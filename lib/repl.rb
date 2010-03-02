require 'treetop'
require 'readline'
require 'pp'

$: << File.dirname(__FILE__)

require 'ast'
require 'environment'
require 'function'
require 'parser'
require 'syntax'

class Repl
  def initialize(env)
    @env = env
    @parser = Parser.new

    Readline.completion_proc = proc do |s|
      @env.bindings.map(&:to_s).grep /^#{Regexp.escape(s)}/
    end
  end

  def run
    while line = Readline.readline('repl> ', true)
      begin
        line = line.strip
        display_result(evaluate(parse(line))) unless line.empty?
      rescue Exception => e
        puts "Error: #{e.inspect}"
        puts e.backtrace
      end
    end

    puts
  end

  private

  def evaluate(ast)
    ast.evaluate(@env)
  end

  def parse(input)
    @parser.parse(input)
  end

  def display_result(result)
    puts "=> #{result.inspect}"
  end
end

env = Environment.new

env.define_syntax(:define) do |env, identifier, expression|
  identifier = identifier.elements[1].identifier
  env.define identifier, expression.eval(env)
end

env.define_syntax(:lambda) do |env, formals, body|
  Function.lambda(env, formals, body)
end

env.define(:+) {|a, b| a + b}
env.define(:*) {|a, b| a * b}

# For debugging. env needs to be a syntax, so it can get at the
# environment.
env.define_syntax(:env) {|env| env}
env.define(:pp) {|arg| pp arg}

Repl.new(env).run
