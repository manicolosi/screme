class Function < Proc
  def initialize(params = nil, body = nil, &block)
    if block_given?
      super(&block)
    else
      super do |env, *args|
        env2 = { params[0] => args[0], params[1] => args[1] }
        body.eval(env2)
      end
    end
  end

  def self.lambda(env, formals, body)
    formals = formals.elements[1].elements[1].elements.map do |formal|
      formal.elements[1].identifier
    end

    Function.new do |*args|
      new_env = Environment.new env
      formals.each_with_index do |formal, i|
        new_env.define formal, args[i]
      end

      body.eval(new_env)
    end
  end

  def apply(env, *args)
    call *args.map {|a| a.eval(env)}
  end
end

