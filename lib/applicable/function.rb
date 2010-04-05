class Function < Proc
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

