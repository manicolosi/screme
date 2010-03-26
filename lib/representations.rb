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

  module InspectRepresentation
    def representation
      inspect
    end
  end

  module BooleanRepresentation
    def representation
      self == true ? '#t' : '#f'
    end
  end

  Object.send :include, Representations::InspectRepresentation
  Array.send :include, Representations::ListRepresentation

  [ TrueClass, FalseClass ].each do |klass|
    klass.send :include, Representations::BooleanRepresentation
  end

  [ Fixnum, Rational, Symbol ].each do |klass|
    klass.send :include, Representations::SimpleRepresentation
  end
end
