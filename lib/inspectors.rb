module Screme
  module Inspectors
    module EmptyListInspector
      def scm_inspect
        '()'
      end
    end

    module SimpleInspector
      def scm_inspect
        to_s
      end
    end

    module InspectInspector
      def scm_inspect
        inspect
      end
    end

    module BooleanInspector
      def scm_inspect
        self == true ? '#t' : '#f'
      end
    end

    Object.send   :include, InspectInspector
    NilClass.send :include, EmptyListInspector

    [ TrueClass, FalseClass ].each do |klass|
      klass.send :include, BooleanInspector
    end

    [ Fixnum, Rational, Symbol ].each do |klass|
      klass.send :include, SimpleInspector
    end
  end
end
