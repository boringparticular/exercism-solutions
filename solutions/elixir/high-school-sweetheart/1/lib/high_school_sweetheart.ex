defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name 
      |> String.trim()
      |> String.first()
  end

  def initial(name) do
    initial = name
      |> first_letter()
      |> String.upcase()

    initial <> "."
  end

  def initials(full_name) do
    full_name
      |> String.split()
      |> Enum.map(&initial/1)
      |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    a = initials(full_name1)
    b = initials(full_name2)
    """
    ❤-------------------❤
    |  #{a}  +  #{b}  |
    ❤-------------------❤
    """
  end
end
