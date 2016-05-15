defmodule Parser do
  def parse(tokens) do
    tokens
      |> parse_single
      |> Tuple.to_list
      |> List.first
  end

  defp parse_single([{:lparen, _} | rest]) do
    {func, rest1} = parse_single(rest)
    {arg, rest2} = parse_single(rest1)

    {
      [
        type: :application,
        function: func,
        arg: arg
      ],
      Enum.drop(rest2, 1)
    }
  end

  defp parse_single([{:lambda, _}, {:name, name}, {:dot, _} | rest]) do
    {body, rest} = parse_single(rest)

    {
      [
        type: :lambda,
        arg: name,
        body: body
      ],
      rest
    }
  end

  defp parse_single([{:name, name} | rest]) do
    { [type: :name, value: name], rest }
  end
end

IO.puts inspect(Parser.parse([{:name, "c"}]))
IO.puts inspect(Parser.parse([
  {:lambda, nil},
  {:name, "x"},
  {:dot, nil},
  {:name, "x"},
]))

IO.puts inspect(Parser.parse([
  {:lparen, nil},
  {:lambda, nil},
  {:name, "x"},
  {:dot, nil},
  {:name, "x"},
  {:lambda, nil},
  {:name, "y"},
  {:dot, nil},
  {:name, "y"},
  {:rparen, nil},
]))
