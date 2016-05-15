defmodule Evaluator do
  def eval(ast) do
    eval_env(ast[:type], ast, [])
  end

  defp eval_env(:lambda, ast, env) do
    [
      type: :closure,
      arg: ast[:arg],
      body: ast[:body],
      env: env
    ]
  end

  defp eval_env(:name, ast, env) do
    env[ast[:value]]
  end

  defp eval_env(:application, ast, env) do
    closure = eval_env(ast[:function][:type], ast[:function], env)
    value = eval_env(ast[:arg][:type], ast[:arg], env)

    eval_env(
      closure[:body][:type],
      closure[:body],
      [ { closure[:arg], value } | closure[:env] ++ env]
    )
  end
end

#defmodule DSL do
#  def lambda(arg, body) do
#    [
#      type: :lambda,
#      arg: arg,
#      body: body
#    ]
#  end
#
#  def name(value) do
#    [
#      type: :name,
#      value: value
#    ]
#  end
#
#  def app(func, arg) do
#    [
#      type: :application,
#      function: func,
#      arg: arg
#    ]
#  end
#
#  def test do
#    IO.puts inspect(
#      Evaluator.eval(
#        lambda(:x, name(:x))
#      )
#    )
#
#    IO.puts inspect(
#      Evaluator.eval(
#        app(
#          lambda(:x, name(:x)),
#          lambda(:y, name(:y))
#        )
#      )
#    )
#
#    IO.puts inspect(
#      Evaluator.eval(
#        app(
#          app(
#            lambda(:x, lambda(:z, name(:x))),
#            lambda(:y, name(:y))
#          ),
#          lambda(:c, name(:c))
#        )
#      )
#    )
#  end
#end
#
#DSL.test
