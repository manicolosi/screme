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

  def self.lambda(env, params, body)
    params = params.elements[1].elements[1].elements.map do |param|
      param.elements[1].text_value
    end

    Function.new do |*args|
      env2 = env.merge({ params[0] => args[0], params[1] => args[1] })
      body.eval(env2)
    end
  end

  def apply(env, *args)
    call *args.map {|a| a.eval(env)}
  end
end

