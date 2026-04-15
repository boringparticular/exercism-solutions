defmodule Username do
  def sanitize([]), do: []
  def sanitize([letter | rest]) when letter in ?a..?z, do: [letter] ++ sanitize(rest)
  def sanitize([?_ | rest]), do: ~c"_" ++ sanitize(rest)
  def sanitize([?ä | rest]), do: ~c"ae" ++ sanitize(rest)
  def sanitize([?ö | rest]), do: ~c"oe" ++ sanitize(rest)
  def sanitize([?ü | rest]), do: ~c"ue" ++ sanitize(rest)
  def sanitize([?ß | rest]), do: ~c"ss" ++ sanitize(rest)
  def sanitize([_letter | rest]), do: sanitize(rest)
end
