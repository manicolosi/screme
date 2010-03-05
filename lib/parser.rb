require 'treetop'

module ExpressionNode
  def to_ast
    if quote.is_a? QuoteNode
      [:quote, expr.to_ast]
    else
      expr.to_ast
    end
  end
end

module QuoteNode
end

module ListNode
  def to_ast
    exprs.elements.map { |e| e.to_ast }
  end
end

module IntegerNode
  def to_ast
    text_value.to_i
  end
end

module StringNode
  def to_ast
    inner.text_value
  end
end

module SymbolNode
  def to_ast
    text_value.to_sym
  end
end

Treetop.load File.dirname(__FILE__) + '/screme.tt'

class Parser < ScremeParser
  def parse(str)
    super.to_ast
  end
end
