require 'forwardable'

require 'function'
require 'syntax'

class Environment
  extend Forwardable

  def initialize(parent = nil)
    @parent = parent
    @bindings = {}
  end

  def_delegator :@bindings, :[]

  def bound?(symbol)
    @bindings.member?(symbol) || (@parent && @parent.bound?(symbol))
  end

  def define(symbol, value = nil, &block)
    if block_given?
      @bindings[symbol] = Function.new(&block)
    else
      @bindings[symbol] = value
    end
  end

  def define_syntax(symbol, &block)
    @bindings[symbol] = Syntax.new(&block)
  end
end
