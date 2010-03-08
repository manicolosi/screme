class Environment
  def initialize(parent = nil)
    @parent = parent
    @bindings = {}
  end

  def bound?(symbol)
    @bindings.member?(symbol) || (@parent && @parent.bound?(symbol))
  end

  def bindings
    @bindings.merge(@parent.nil? ? {} : @parent.bindings)
  end

  def merge(another)
    @bindings.merge! another.bindings
  end

  def [](symbol)
    @bindings[symbol] || (@parent && @parent[symbol])
  end

  def define(symbol, value = nil, &block)
    if block_given?
      @bindings[symbol] = Function.new(&block)
    else
      @bindings[symbol] = value
    end
  end

  def define_special(symbol, &block)
    @bindings[symbol] = Syntax.new(&block)
  end
end
