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
    reset_prompt

    while line = Readline.readline(@prompt, false)
      begin
        @lines << line
        input = @lines.join("\n")

        lparens, rparens = *count_parens(input)
        if lparens == rparens

          unless /\n +/ =~ input
            input.gsub!(/\n/, "\n" + " " * 9)
          end

          Readline::HISTORY.push(input)
          reset_prompt
          display_result(eval(input))
        elsif lparens > rparens
          @prompt = "*...>    "
        else
          raise 'Unexpected right parenthesis.'
        end
      rescue Exception => e
        reset_prompt
        puts "Error: #{e.inspect}"
        puts e.backtrace
      end
    end

    puts
  end

  private

  def reset_prompt
    @prompt = 'repl> '
    @lines = []
  end

  def count_parens(str)
    # FIXME: Stupid thing won't work for strings.
    lparens = str.each_char.reduce(0) do |acc, c|
      acc + (c == '(' ? 1 : 0)
    end

    rparens = str.each_char.reduce(0) do |acc, c|
      acc + (c == ')' ? 1 : 0)
    end

    [lparens, rparens]
  end

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
        'print-env' => Syntax.new {|env| puts env.inspect},
        'define' => Syntax.new do |env, identifier, expression|
          env[identifier.elements[1].text_value] = expression.eval(env)
        end,
        'lambda' => Syntax.new do |env, params, body|
          Function.lambda(env, params, body)
        end
      }

SchemeRepl.new(env).run
