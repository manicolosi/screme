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
    if expr.atom?
      expr
    elsif expr.first == :unquote
      expr[1].evaluate(env)
    else
      expr.map {|e| [:quasiquote, e].evaluate(env)}
    end
  end

  define_special(:let) do |env, bindings, body|
    variables = bindings.map(&:first)
    inits     = bindings.map(&:last)

    [[:lambda, variables, body], *inits].evaluate(env)
  end

  define(:atom?) { |expr| expr.atom? }

  define(:+) { |a, b| a + b }
  define(:*) { |a, b| a * b }
end
