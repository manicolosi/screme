require 'treetop'
require 'pp'

Treetop.load 'grammar.tt'

class SchemeRepl
  def initialize(env)
    @env = env
    @parser = SchemeParser.new
  end

  def run
    while true
      input = prompt

      unless input.empty?
        result = eval(input)
        display_result(result)
      end
    end
  end

  private

  def eval(str)
    parse(str).eval(@env)
  end

  def parse(str)
    @parser.parse(str)
  end

  def prompt
    print "repl> "
    input = gets

    if input.nil?
      puts
      exit
    end

    input.chomp
  end

  def display_result(result)
    print "=> "
    pp result
  end
end

env = {'x' => 2, 'y' => 3}
SchemeRepl.new(env).run
