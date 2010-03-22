module Representations
  module ListRepresentation
    def representation
      '(' + map(&:representation).join(' ') + ')'
    end
  end

  module SimpleRepresentation
    def representation
      to_s
    end
  end

  module StringRepresentation
    def representation
      inspect
    end
  end

  [ Fixnum, Rational, Symbol ].each do |klass|
    klass.send :include, Representations::SimpleRepresentation
  end

  Array.send  :include, Representations::ListRepresentation
  String.send :include, Representations::StringRepresentation
end
