Code.require_file("evaluator.exs")
Code.require_file("parser.exs")
Code.require_file("tokenizer.exs")
Code.require_file("pretty_printer.exs")

System.argv()
  |> List.first
  |> Tokenizer.tokenize
  |> Parser.parse
  |> Evaluator.eval 
  |> PrettyPrinter.pretty 
  |> IO.puts
