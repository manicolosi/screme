require 'treetop'

module Screme
  Node = Treetop::Runtime::SyntaxNode

  module ExpressionNode
    def to_ast
      expr.to_ast
    end
  end

  module QuotedNode
    def to_ast
      [quote_type, expression.to_ast]
    end

    def quote_type
      case quote.text_value
      when "'": :quote
      when "`": :quasiquote
      when ",": :unquote
      when ",@": :"unquote-splicing"
      end
    end
  end

  module ListNode
    def to_ast
      exprs.elements.map { |e| e.to_ast }
    end
  end

  class Boolean < Node
    def to_ast
      value
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
end
