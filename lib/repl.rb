require 'readline'

require File.dirname(__FILE__) + '/screme'

module Screme
  class Repl
    def initialize
      @interpreter = Interpreter.new

      Readline.completion_proc = proc do |s|
        identifiers = @interpreter.env.bindings.keys
        identifiers.map(&:to_s).grep /^#{Regexp.escape(s)}/
      end
    end

    def run
      reset

      @lines = []

      while line = Readline.readline(@prompt, false)
        begin
          input = (@lines << line).join("\n")
          l, r = *count_parens(input)

          if l == r
            push_history(input)
            display_result(evaluate(input))
            reset
          elsif l > r
            @prompt = '... '
          else
            raise SyntaxError, 'Unexpected right parenthesis'
          end

        rescue Exception => e
          puts "#{e.class}: #{e.to_s}"
          reset
        end
      end

      print "\n"
    end

    private

    def reset
      @prompt = '>>> '
      @lines  = []
    end

    def push_history(input)
      input.gsub!(/\n/, "\n    ")
      Readline::HISTORY.push(input)
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

    def evaluate(input)
      @interpreter.parse_and_eval(input) unless input.empty?
    end

    def display_result(result)
      puts result.scm_inspect unless result.nil?
    end
  end
end

Screme::Repl.new.run
