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
      raise "Unbound symbol \"#{ self }\"."
    end
  end
end

module FunctionApplicationEvaluation
  def evaluate(env = {})
    fn = first.evaluate(env)
    args = self[1..-1]

    fn.call env, *args
  end
end

Fixnum.send :include, SelfEvaluation
String.send :include, SelfEvaluation
Symbol.send :include, SymbolEvaluation
Array.send  :include, FunctionApplicationEvaluation
