require File.dirname(__FILE__) + '/../lib/screme.rb'
require 'term/ansicolor'

class NativeTest
  def self.run(file)
    @nesting = 0

    interpreter = ScremeInterpreter.new.tap do |i|
      i.define_special(:context) do |env, descript, *asserts|
        show :reset, '', descript

        @nesting += 1
        asserts.each {|a| a.evaluate(env)}
        @nesting -= 1
        print "\n" unless @nesting > 0
      end

      i.define_special(:assert) do |env, descript, expr|
        [[:if, [:'=', true, expr], :pass, :fail],
          descript, [:quote, expr]].evaluate(env)
      end

      i.define(:pass) do |descript, expr|
        show :green, '+', descript
      end

      i.define(:fail) do |descript, expr|
        show :red, '-', descript
        show :red, ' ', "FAILED: #{ expr.representation }"
      end

      i.define_special(:pending) do |env, descript, pending_on|
        show :yellow, '*', descript
        pending_on = "not implemented" unless pending_on.is_a? String
        show :yellow, ' ', "PENDING: #{ pending_on }"
      end

      input = File.open(file).lines.to_a.to_s
      i.parse_and_eval(input)
    end
  end

  private

  def self.show(color, prefix, text)
    prefix += " " unless prefix == ""
    prefix = (" " * @nesting) + prefix
    puts Term::ANSIColor.send color, prefix + text
  end
end

ARGV.each do |file|
  NativeTest.run file
end

