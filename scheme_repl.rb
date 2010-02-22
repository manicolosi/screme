require 'treetop'
require 'readline'
require 'pp'

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
      line = line.strip
      display_result(eval(line)) unless line.empty?
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

env = {'x' => 2, 'y' => 3,
       'theresa' => 'cute', 'test' => 12,
       '+' => 2+3, 'string->int' => 42}
SchemeRepl.new(env).run
