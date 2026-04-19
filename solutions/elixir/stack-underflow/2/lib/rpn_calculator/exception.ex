defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        value -> %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end
  end

  def divide([]), do: raise(StackUnderflowError, "when dividing")
  def divide([_]), do: raise(StackUnderflowError, "when dividing")
  def divide([0, _dividend]), do: raise DivisionByZeroError
  def divide([divisor, dividend]), do: dividend / divisor
end
