class Program
  attr_reader :expressions

  def initialize(expressions)
    @expressions = expressions
  end

  def evaluate(env)
    @expressions.map {|expr| expr.evaluate(env)}.last
  end
end

module SelfEvaluation
  def evaluate(env = nil)
    self
  end
end

module SymbolEvaluation
  def evaluate(env = {})
    bound_pred = if env.respond_to? :bound?
      :bound?
    else
      :key?
    end

    if env.send bound_pred, self
      env[self]
    else
      raise "Unbound symbol: #{self}"
    end
  end
end

module FunctionApplicationEvaluation
  def evaluate(env = {})
    fn = first.evaluate(env)
    args = self[1..-1]

    fn.call env, *args
  rescue NoMethodError
    raise "Can't apply: #{fn.scm_inspect}"
  end
end

[ Fixnum, Rational, String, TrueClass, FalseClass ].each do |klass|
  klass.send :include, SelfEvaluation
end

Symbol.send :include, SymbolEvaluation
Array.send  :include, FunctionApplicationEvaluation
