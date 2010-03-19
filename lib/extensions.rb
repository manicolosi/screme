module ScremeExtensions
  module Atom
    def atom?
      true
    end
  end

  module List
    def atom?
      false
    end
  end
end

[ Fixnum, String, Symbol ].each do |klass|
  klass.send :include, ScremeExtensions::Atom
end

Array.send  :include, ScremeExtensions::List

