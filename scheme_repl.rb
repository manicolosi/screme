require 'treetop'
require 'readline'
require 'pp'

require 'function'
require 'syntax'

Treetop.load 'grammar.tt'

class SchemeRepl
  def initialize(env)
    @env = env
    @parser = SchemeParser.new

    Readline.completion_proc = proc do |s|
      @env.keys.grep /^#{Regexp.escape(s)}/
    end
  end

  def run
    while line = Readline.readline('repl> ', true)
      begin
        line = line.strip
        display_result(eval(line)) unless line.empty?
      rescue Exception => e
        puts "Error: #{e.inspect}"
        puts e.backtrace
      end
    end

    puts
  end

  private

  def eval(str)
    parse(str).eval(@env)
  end

  def parse(str)
    @parser.parse(str)
  end

  def display_result(result)
    puts "=> #{result.inspect}"
  end
end

env = { '+' => Function.new {|a, b| a + b},
        '*' => Function.new {|a, b| a * b},
        '=' => Function.new {|a, b| a == b},
        'define' => Syntax.new do |env, identifier, expression|
          env[identifier.elements[1].text_value] = expression.eval(env)
        end,
        'lambda' => Syntax.new do |env, params, body|
          Function.lambda(env, params, body)
        end,
        # For debugging
        'pp' => Function.new {|arg| pp arg},
        'env' => Syntax.new {|env| env}
      }

SchemeRepl.new(env).run
