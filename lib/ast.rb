module SelfEvaluation
  def evaluate(env = nil)
    self
  end
end

module SymbolEvaluation
  def evaluate(env = {})
    if env.key? self
      env[self]
    else
      raise "Unbound symbol \"#{ self }\"."
    end
  end
end

module FunctionApplicationEvaluation
  def evaluate(env = {})
    fn = first.evaluate(env)
    args = self[1..-1].map {|arg| arg.evaluate(env)}

    fn.call *args
  end
end

Fixnum.send :include, SelfEvaluation
String.send :include, SelfEvaluation
Symbol.send :include, SymbolEvaluation
Array.send  :include, FunctionApplicationEvaluation
