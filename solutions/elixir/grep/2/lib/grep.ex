defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    filter_fn = build_filter(flags, pattern)
    prepend_line_number? = "-n" in flags
    prepend_filename? = length(files) > 1
    only_filename? = "-l" in flags

    if only_filename? do
      results =
        files
        |> Enum.map(fn file ->
          if file |> File.stream!() |> Enum.any?(&filter_fn.(&1)), do: file
        end)
        |> Enum.filter(&(&1 != nil))
        |> Enum.join("\n")
        |> case do
          "" -> ""
          result -> "#{result}\n"
        end
    else
      files
      |> Enum.map(fn file ->
        file
        |> File.stream!()
        |> Stream.with_index(1)
        |> Stream.filter(fn {line, _index} -> filter_fn.(line) end)
        |> Stream.map(fn {line, index} ->
          line = if prepend_line_number?, do: "#{index}:#{line}", else: line
          if prepend_filename?, do: "#{file}:#{line}", else: line
        end)
      end)
      |> Stream.concat()
      |> Enum.join("")
    end
  end

  defp build_filter(flags, pattern) do
    exact? = "-x" in flags
    ignore_case? = "-i" in flags
    invert? = "-v" in flags

    match_fn = if exact?, do: &Kernel.==/2, else: &String.contains?/2
    pattern = if ignore_case?, do: String.downcase(pattern), else: pattern

    fn line ->
      line = String.trim(line, "\n")
      line = if ignore_case?, do: String.downcase(line), else: line
      result = match_fn.(line, pattern)
      if invert?, do: not result, else: result
    end
  end
end
