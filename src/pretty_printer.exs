defmodule PrettyPrinter do
  def pretty(ast) do
    dopretty(ast[:type], ast)
  end

  def dopretty(:name, ast) do
    Atom.to_string(ast[:value])
  end

  def dopretty(:application, ast) do
    "(#{dopretty(ast[:function][:type], ast[:function])} #{dopretty(ast[:arg][:type], ast[:arg])})"
  end

  def dopretty(_, ast) do
    "\\#{ast[:arg]}.#{dopretty(ast[:body][:type], ast[:body])}"
  end
end
