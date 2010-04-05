module Screme
  module Runtime

    class Pair
      include Enumerable

      attr_reader :car, :cdr

      def self.list(a)
        return nil if a.empty?

        car = a[0]
        car = list car if Array === car

        cdr = list a[1..-1]

        new car, cdr
      end

      def initialize(car, cdr)
        @car, @cdr = car, cdr
      end

      def cadr
        cdr.car
      end

      def scm_inspect(parens = true)
        s = ''
        s << '(' if parens

        s << @car.scm_inspect
        s << ' ' unless @cdr.nil?

        if Pair === @cdr
          s << @cdr.scm_inspect(false)
        elsif @cdr.nil?
          s << ''
        else
          s << '. ' + @cdr.scm_inspect
        end
        s << ')' if parens

        s
      end

      alias inspect scm_inspect

      def evaluate(env)
        fn = car.evaluate(env)
        args = cdr.to_a

        if fn.respond_to? :call
          fn.call env, *args
        else
          raise Runtime::RuntimeError, "Can't apply: #{fn.scm_inspect}"
        end
      end

      def each
        yield car
        cdr.each { |obj| yield obj } if Pair === cdr
      end

      def ==(other)
        to_a == other.to_a
      end
    end

  end
end
