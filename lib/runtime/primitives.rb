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
    expr.quasiquote(env)
  end

  define_special(:let) do |env, bindings, body|
    variables = bindings.map(&:first)
    inits     = bindings.map(&:last)

    [[:lambda, variables, body], *inits].evaluate(env)
  end

  define_special(:let) do |env, bindings, body|
    variables = bindings.map(&:first)
    inits     = bindings.map(&:last)

    [[:lambda, variables, body], *inits].evaluate(env)
  end

  define(:atom?) { |expr| expr.atom? }

  define_special(:if) do |env, condition, then_expr, else_expr|
    expr = condition.evaluate(env) ? then_expr : else_expr
    expr.evaluate(env)
  end

  define(:+) { |a, b| a + b }
  define(:*) { |a, b| a * b }
end
