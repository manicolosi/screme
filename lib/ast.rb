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
    fn_sym = first
    fn_str = fn_sym.to_s
    args = self[1..-1]

    if fn_str.match /^#/
      # Ruby Interop
      method = fn_str.slice(1..-1).to_sym
      args.map! {|a| a.evaluate(env)}
      args[0].send method, *args[1..-1]
    else
      fn = fn_sym.evaluate(env)
      fn.call env, *args
    end
  end
end

Fixnum.send :include, SelfEvaluation
String.send :include, SelfEvaluation
TrueClass.send :include, SelfEvaluation
FalseClass.send :include, SelfEvaluation
Symbol.send :include, SymbolEvaluation
Array.send  :include, FunctionApplicationEvaluation
