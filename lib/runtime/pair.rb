module Screme
  module Runtime

    class Pair
      def self.from_a(a)
      end

      attr_reader :car, :cdr

      def initialize(car, cdr)
        @car, @cdr = car, cdr
      end

      def scm_inspect
        "(#{@car.scm_inspect} . #{@cdr.scm_inspect})"
      end
    end

  end
end
