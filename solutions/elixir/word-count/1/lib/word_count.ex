defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split([".", ",", ":", "!", "?", "_", " ", "\t", "\n", "&", "@", "$", "%", "^"], trim: true)
    |> Enum.reduce(%{}, fn word, acc ->
      word = String.trim(word, "'")
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end
end
