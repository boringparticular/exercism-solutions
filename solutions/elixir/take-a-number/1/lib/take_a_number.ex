defmodule TakeANumber do
  def start() do
    spawn(&server/0)
  end

  def server(state \\ 0) do
    receive do
      {:report_state, sender_pid} -> 
        send(sender_pid, state)
        server(state)
      {:take_a_number, sender_pid} ->
        state = state + 1
        send(sender_pid, state)
        server(state)
      :stop -> nil
      _ -> server(state)
    end
  end
end
