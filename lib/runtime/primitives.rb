module Screme
  module Runtime

    class ScremeForms
      def self.define(symbol, value = nil, &block)
        @env ||= Environment.new
        @env.define(symbol, value, &block)
      end

      def self.define_special(symbol, &block)
        @env ||= Environment.new
        @env.define_special(symbol, &block)
      end

      def self.env
        @env
      end
    end

    class Primitives < ScremeForms
      define_special(:define) do |env, sym, expr|
        env.define sym, expr.evaluate(env)
      end

      define_special(:lambda) do |env, formals, body|
        Function.lambda(env, formals, body)
      end

      define_special(:quote) do |env, expr|
        expr
      end

      define_special(:quasiquote) do |env, expr|
        expr.quasiquote(env)
      end

      define_special(:let) do |env, bindings, body|
        variables = bindings.map(&:first)
        inits     = bindings.map(&:last)

        [[:lambda, variables, body], *inits].evaluate(env)
      end

      define_special(:let) do |env, bindings, body|
        variables = bindings.map(&:first)
        inits     = bindings.map(&:last)

        [[:lambda, variables, body], *inits].evaluate(env)
      end

      ## List functions
      define(:cons) { |a, b| Runtime::Pair.new a, b }
      define(:car) { |cons| cons.car }
      define(:cdr) { |cons| cons.cdr }

      ## Predicates
      define(:null?) { |obj| obj.nil? }
      define(:pair?) { |obj| Runtime::Pair === obj }
      # TODO: Re-write in Screme
      define(:atom?) do |obj|
        [:and, [:not, [:pair?, [:quote, obj]]],
               [:not, [:null?, [:quote, obj]]]].evaluate(self.env)
      end

      define_special(:if) do |env, condition, then_expr, else_expr|
        expr = condition.evaluate(env) ? then_expr : else_expr
        expr.evaluate(env)
      end

      define_special(:and) do |env, a, b|
        [:if, a, b, false].evaluate(env)
      end

      define(:not) do |a|
        !a
      end

      define(:"=") do |*z|
        !!z.reduce { |acc, a| acc if acc == a }
      end

      define(:+) { |*z| z.reduce(&:+) || 0 }
      define(:*) { |*z| z.reduce(&:*) || 1 }

      define(:-) do |a, *z|
        z.empty? ? -a : [a, *z].reduce(&:-)
      end

      define(:/) do |a, *z|
        z.empty? ? Rational(1, a) : [a, *z].reduce(&:quo)
      end
    end

  end
end
