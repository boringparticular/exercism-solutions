defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)
    yelling? = String.upcase(input) != String.downcase(input) and input == String.upcase(input)
    question? = String.ends_with?(input, "?")
    
    cond do
      yelling? and question? -> "Calm down, I know what I'm doing!"
      yelling? -> "Whoa, chill out!"
      question? -> "Sure."
      input == "" -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
