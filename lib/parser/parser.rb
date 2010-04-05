require 'treetop'

module Screme
  Treetop.load File.dirname(__FILE__) + '/screme.tt'

  class Parser < ScremeParser
    class SyntaxError < RuntimeError; end

    Node = Treetop::Runtime::SyntaxNode

    def parse(str)
      syntax = super
      raise SyntaxError, "\"#{ str }\""  if syntax.nil?

      syntax.value
    end

    class Program < Node
      def value
        ::Program.new elements.map(&:value)
      end
    end

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
        if exprs.elements.empty?
          nil
        else
          exprs.elements.map { |e| e.value }
        end
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

    class Rational < Node
      def value
        Rational *text_value.split('/').map(&:to_i)
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
  end
end
