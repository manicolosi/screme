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
        if bodies.empty?
          pending(description)
        else
          failures = bodies.reject { |body| body.evaluate(env) == true }
          if failures.empty?
            pass(description)
          else
            fail(description, failures)
          end
        end
      end

      input = File.open(file).lines.to_a.to_s
      i.parse_and_eval(input)
    end
  end

  private

  def self.pending(description)
    show :yellow, '*', description
    show :yellow, ' ', "PENDING: not implemented"
  end

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

