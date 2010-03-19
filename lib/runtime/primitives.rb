require 'lib/environment.rb'

class ScremeForms
  def self.define(symbol, value = nil, &block)
    @env ||= Environment.new
    @env.define(symbol, value, &block)
  end

  def self.define_special(symbol, &block)
    @env ||= Environment.new
    @env.define_special(symbol, &block)
  end

  def self.env
    @env
  end
end

class Primitives < ScremeForms
  define_special(:define) do |env, sym, expr|
    env.define sym, expr.evaluate(env)
  end

  define_special(:lambda) do |env, formals, body|
    Function.lambda(env, formals, body)
  end

  define_special(:quote) do |env, expr|
    expr
  end

  define_special(:quasiquote) do |env, expr|
    if expr.is_a? Array and expr.first == :unquote
      expr[1].evaluate(env)
    else
      expr
    end
  end

  define(:+) { |a, b| a + b }
  define(:*) { |a, b| a * b }
end
