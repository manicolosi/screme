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

module ArrayEvaluation
  def evaluate(env = {})
    Screme::Runtime::Pair.from_a(self).evaluate(env)
  end
end

[ Fixnum, Rational, String, TrueClass, FalseClass ].each do |klass|
  klass.send :include, SelfEvaluation
end

Symbol.send :include, SymbolEvaluation
Array.send  :include, ArrayEvaluation
