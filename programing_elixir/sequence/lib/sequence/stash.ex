defmodule Sequence.Stash do
  use GenServer

  def start_link(initial_value) do
    {:ok, _pid,} = GenServer.start_link(__MODULE__, initial_value)
  end

  def save_value(pid, value), do: GenServer.cast pid, {:save_value, value}
  def get_value(pid),         do: GenServer.call pid, :get_value


  def handle_cast({:save_value, value}, _current_value), do: {:noreply, value}
  def handle_call(:get_value, _from, current_value), do: {:reply, current_value, current_value}
end
