defmodule BirdCount do
  def today([]), do: nil
  def today([today | _]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | rest]), do: [today + 1 | rest]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_today | rest]), do: has_day_without_birds?(rest)

  def total([]), do: 0
  def total([today | rest]), do: today + total(rest)

  def busy_days([]), do: 0
  def busy_days([today | rest]) when today >= 5, do: 1 + busy_days(rest)
  def busy_days([_today | rest]), do: busy_days(rest)
end
