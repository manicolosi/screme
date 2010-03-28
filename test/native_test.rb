require File.dirname(__FILE__) + '/../lib/screme.rb'
require 'term/ansicolor'

class NativeTest
  def self.run(file)
    @nesting = 0

    interpreter = Screme::Interpreter.new.tap do |i|
      i.define_special(:context) do |env, descript, *asserts|
        show_context descript

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
    show_example :pending, description
    show_reason  :pending, 'not implemented'
  end

  def self.fail(description, bodies)
    show_example :fail, description
    bodies.each { |body| show_reason :fail, body.representation }
  end

  def self.pass(description)
    show_example :pass, description
  end

  COLORS =  { :pass => :green, :fail => :red,     :pending => :yellow }
  PREFIX =  { :pass => '+',    :fail => '-',      :pending => '*' }
  REASONS = {                  :fail => 'FAILED', :pending => 'PENDING' }

  def self.show_context(description)
    puts nested_prefix + description
  end

  def self.show_example(status, description)
    color  = COLORS[status]
    prefix = PREFIX[status]
    puts in_color(color, nested_prefix(prefix) + description)
  end

  def self.show_reason(status, reason)
    color  = COLORS[status]
    reason = "#{ REASONS[status] }: #{ reason }"
    puts in_color(color, nested_prefix(' ') + reason)
  end

  def self.in_color(color, text)
    Term::ANSIColor.send color, text
  end

  def self.nested_prefix(prefix = '')
    leading_ws = ' ' * @nesting
    if prefix.empty?
      leading_ws
    else
      leading_ws + prefix + ' '
    end
  end
end

ARGV.each do |file|
  NativeTest.run file
end

