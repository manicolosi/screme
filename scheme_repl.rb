require 'treetop'
require 'readline'
require 'pp'

Treetop.load 'grammar.tt'

class Function < Proc
  def initialize(params = nil, body = nil, &block)
    if block_given?
      super(&block)
    else
      super do |env, *args|
        env2 = { params[0] => args[0], params[1] => args[1] }
        body.eval(env2)
      end
    end
  end

  def self.lambda(env, params, body)
    params = params.elements[1].elements[1].elements.map do |param|
      param.elements[1].text_value
    end

    Function.new do |*args|
      env2 = { params[0] => args[0], params[1] => args[1] }.merge(env)
      body.eval(env2)
    end
  end

  def apply(env, *args)
    call *args.map {|a| a.eval(env)}
  end
end

class Syntax < Proc
  def apply(env, *args)
    call env, *args
  end
end

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
    print "=> "
    pp result
  end
end

env = { '+' => Function.new {|a, b| a + b},
        '*' => Function.new {|a, b| a * b},
        '=' => Function.new {|a, b| a == b},
        'env' => Syntax.new {|env| pp env},
        'define' => Syntax.new do |env, identifier, expression|
          env[identifier.elements[1].text_value] = expression.eval(env)
        end,
        'lambda' => Syntax.new do |env, params, body|
          Function.lambda(env, params, body)
        end
      }

SchemeRepl.new(env).run
