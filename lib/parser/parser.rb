require 'treetop'

module Screme
  Node = Treetop::Runtime::SyntaxNode

  class Expression < Node
    def value
      expr.value
    end
  end

  class Quoted < Node
    def value
      [quote_type, expression.value]
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

  class List < Node
    def value
      exprs.elements.map { |e| e.value }
    end
  end

  class Boolean < Node
    def value
      text_value == '#t' ? true : false
    end
  end

  class Integer < Node
    def value
      text_value.to_i
    end
  end

  class String < Node
    def value
      text_value.gsub('\\"', '"').gsub('\\\\', '\\').gsub(/^"|"$/, '')
    end
  end

  class Identifier < Node
    def value
      text_value.to_sym
    end
  end

  class SyntaxError < RuntimeError
  end

  Treetop.load File.dirname(__FILE__) + '/screme.tt'

  class Parser < ScremeParser
    def parse(str)
      syntax = super
      raise SyntaxError, "\"#{ str }\""  if syntax.nil?

      syntax.value
    end
  end
end
