class Macro < Proc
  def self.macro(env, transformer)
    transformer = transformer.evaluate(env)

    Macro.new do |env, *args|
      transformer.call env, *args
    end
  end

  def call(env, *args)
    super
  end
end

