require 'pp'

module SchemeObject
  def to_scheme
    self
  end

  def eval(env={})
    self
  end
end

class String
  include SchemeObject
end

class Fixnum
  include SchemeObject
end

class Array
  def to_scheme
    map(&:to_scheme)
  end

  def eval(env={})
    f = self[0].eval(env)
    args = self[1..-1].map {|arg| arg.eval(env)}

    raise "'#{self[0]}' is undefined!" if f.nil?

    f.call *args
  end
end

class Symbol
  def to_scheme
    self
  end

  def eval(env={})
    env[self]
  end
end

class SchemeRuntime
  def initialize
    @env = {}

    define(:x, 5)
    define(:y, 15)
    define(:+) {|a,b| a + b}
    define(:-) {|a,b| a - b}
    define(:*) {|a,b| a * b}
    define(:/) {|a,b| a / b}

    # Problem with this is ident is eval'd before we get it, so we only
    # end up with its value, which is normally nil if it hasn't been
    # defined before. That's why this is a special form.
    #
    # Solution? Separate "bindings/variables" and "special forms".
    # Define needs to be a special form to prevent the normal rules from
    # expanding ident. Special forms can be kept in another hash table.
    define(:define) do |ident, value|
      define(ident, value)
    end
  end

  def define(sym, value = nil, &blk)
    if block_given?
      @env[sym] = blk.to_proc
    else
      @env[sym] = value
    end
  end

  def eval(ast)
    ast.to_scheme.eval(@env)
  end
end
