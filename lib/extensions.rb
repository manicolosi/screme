module ScremeExtensions
  module Atom
    def quasiquote(env)
      self
    end
  end

  module List
    def to_list
      Screme::Runtime::Pair.list self
    end

    class SplicingList < Array
    end

    def quasiquote(env)
      if first == :unquote
        self[1].evaluate(env)
      elsif first == :"unquote-splicing"
        SplicingList.new(self[1].evaluate(env))
      else
        result = []
        map {|e| e.quasiquote(env)}.each do |e|
          if e.is_a? SplicingList
            e.each do |e|
              result << e
            end
          else
            result << e
          end
        end

        result
      end
    end
  end
end

[ Fixnum, String, Symbol, TrueClass, FalseClass ].each do |klass|
  klass.send :include, ScremeExtensions::Atom
end

Array.send  :include, ScremeExtensions::List
