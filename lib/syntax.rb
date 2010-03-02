class Syntax < Proc
  def apply(env, *args)
    call env, *args
  end
end

