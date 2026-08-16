defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @strip_pattern ~r/[.()+\s-]/
  @non_digits_pattern ~r/\D/
  @valid_number_pattern ~r/[2-9]\d{2}[2-9]\d{6}/
  
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> String.replace(@strip_pattern, "")
    |> validate()
  end

  defp validate(<<"1", number::binary-size(10)>>), do: validate(number)
  defp validate(<<"0", _::binary-size(9)>>), do: {:error, "area code cannot start with zero"}
  defp validate(<<"1", _::binary-size(9)>>), do: {:error, "area code cannot start with one"}
  defp validate(<<_::binary-size(3), "0", _::binary-size(6)>>), do: {:error, "exchange code cannot start with zero"}
  defp validate(<<_::binary-size(3), "1", _::binary-size(6)>>), do: {:error, "exchange code cannot start with one"}
  
  defp validate(<<number::binary-size(10)>>) do
    cond do
      String.match?(number, @valid_number_pattern) -> {:ok, number}
      String.match?(number, @non_digits_pattern) -> {:error, "must contain digits only"}
    end
  end

  defp validate(number) do
    cond do
      String.length(number) < 10 -> {:error, "must not be fewer than 10 digits"}
      String.length(number) > 11 -> {:error, "must not be greater than 11 digits"}
      String.length(number) == 11 -> {:error, "11 digits must start with 1"}
    end
  end
end
