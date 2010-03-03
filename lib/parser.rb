require 'treetop'

module ExpressionNode
  def to_ast
    expr.to_ast
  end
end

module QuotedNode
  def to_ast
    [:quote, expression.to_ast]
  end
end

module ListNode
  def to_ast
    exprs.elements.map { |e| e.to_ast }
  end
end

module BooleanNode
  def to_ast
    if text_value == '#t'
      true
    elsif text_value == '#f'
      false
    end
  end
end

module IntegerNode
  def to_ast
    text_value.to_i
  end
end

module StringNode
  def to_ast
    inner.text_value.gsub('\"', '"').gsub('\\\\', '\\')
  end
end

module IdentifierNode
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
