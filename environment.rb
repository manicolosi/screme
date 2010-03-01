require 'forwardable'

require 'function'

class Environment
  extend Forwardable

  def initialize
    @bindings = {}
  end

  def_delegator :@bindings, :[]

  def define(symbol, value = nil, &block)
    if block_given?
      @bindings[symbol] = Function.new(&block)
    else
      @bindings[symbol] = value
    end
  end

  def bound?(symbol)
    @bindings.member? symbol
  end
end
