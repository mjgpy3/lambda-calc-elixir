defmodule Tokenizer do
  def tokenize(text) do
    text
      |> String.codepoints
      |> dotokenize
  end

  defp dotokenize(["\\" | rest]) do
    [{:lambda, nil} | dotokenize(rest)]
  end

  defp dotokenize(["." | rest]) do
    [{:dot, nil} | dotokenize(rest)]
  end

  defp dotokenize(["(" | rest]) do
    [{:lparen, nil} | dotokenize(rest)]
  end

  defp dotokenize([")" | rest]) do
    [{:rparen, nil} | dotokenize(rest)]
  end

  defp dotokenize([c | rest]) do
    if String.contains?("abcdefghijklmnopqrstuvwxyz", c) do
      [{:name, c} | dotokenize(rest)]
    else
      dotokenize(rest)
    end
  end

  defp dotokenize([]) do
    []
  end

end

#IO.puts inspect(Tokenizer.tokenize("\\\\"))
#IO.puts inspect(Tokenizer.tokenize("\\."))
#IO.puts inspect(Tokenizer.tokenize("(\\x . x \\y . y)"))
