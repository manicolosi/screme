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

      i.define_special(:assert) do |env, description, *bodies|
        failures = bodies.reject do |body|
          body.evaluate(env) == true
        end

        if failures.length > 0
          fail(description, failures)
        else
          pass(description)
        end
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

  def self.fail(description, bodies)
    show :red, '-', description
    bodies.each { |body| show :red, ' ', "FAILED: #{body.representation}" }
  end

  def self.pass(description)
    show :green, '+', description
  end

  def self.show(color, prefix, text)
    prefix += " " unless prefix == ""
    prefix = (" " * @nesting) + prefix
    puts Term::ANSIColor.send color, prefix + text
  end
end

ARGV.each do |file|
  NativeTest.run file
end

