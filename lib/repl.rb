require 'readline'

require File.dirname(__FILE__) + '/screme'

class Repl
  def initialize
    @interpreter = ScremeInterpreter.new

    Readline.completion_proc = proc do |s|
      @interpreter.env.bindings.map(&:to_s).grep /^#{Regexp.escape(s)}/
    end
  end

  def run
    while line = Readline.readline('repl> ', true)
      begin
        line = line.strip
        display_result(@interpreter.parse_and_eval(line)) unless line.empty?
      rescue Exception => e
        puts "Error: #{e.inspect}"
        puts e.backtrace
      end
    end

    puts
  end

  private

  def display_result(result)
    puts "=> #{result.representation}"
  end
end

Repl.new.run
