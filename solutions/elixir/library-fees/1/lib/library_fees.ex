defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime
      |> NaiveDateTime.to_date()
      |> Date.add(days_to_add)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date)
      |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)
    discount = if monday?(return), do: 0.5, else: 1
    
    checkout
      |> return_date()
      |> days_late(return)
      |> Kernel.*(rate)
      |> Kernel.*(discount)
      |> trunc()
  end
end
