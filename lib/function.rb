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
    Function.new do |*args|
      new_env = Environment.new env
      formals.each_with_index do |formal, i|
        new_env.define formal, args[i]
      end

      body.evaluate(new_env)
    end
  end

  def call(env, *args)
    super *args.map {|a| a.evaluate(env)}
  end
end

