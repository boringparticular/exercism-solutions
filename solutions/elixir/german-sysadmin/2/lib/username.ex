defmodule Username do
  def sanitize(username) do
    case username do
      [letter | rest] when letter in ?a..?z -> [letter | sanitize(rest)]
      [?_ | rest] -> [?_ | sanitize(rest)]
      [?ä | rest] -> [?a, ?e | sanitize(rest)]
      [?ö | rest] -> [?o, ?e | sanitize(rest)]
      [?ü | rest] -> [?u, ?e | sanitize(rest)]
      [?ß | rest] -> [?s, ?s | sanitize(rest)]
      [_letter | rest] -> sanitize(rest)
      _ -> []
    end
  end
end
