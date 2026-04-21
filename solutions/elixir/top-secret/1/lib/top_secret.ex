defmodule TopSecret do
  def to_ast(string) do
      Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({def_type, _meta, [head | _]} = ast, acc) when def_type in [:def, :defp] do
    {name, args} = 
      case head do 
        {:when, _, [{name, _, args} | _]} -> {name, args}
        {name, _, args} -> {name, args}
      end
    arity = if args, do: length(args), else: 0
    {ast, [to_string(name) |> String.slice(0, arity) | acc]}
  end
  
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {_ast, secret} = string
      |> to_ast()
      |> Macro.prewalk([], &decode_secret_message_part/2)

    secret |> Enum.reverse() |> Enum.join()
  end
end
