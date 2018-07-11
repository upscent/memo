defmodule Sequence.Server do
  use GenServer

  @name :list_server
  def start_link(pid),         do: GenServer.start_link(__MODULE__, pid, name: @name)
  def next_number,             do: GenServer.call @name, :next_number
  def set_number(num),         do: GenServer.call @name, {:set_number, num}
  def increment_number(delta), do: GenServer.cast @name, {:increment_number, delta}

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    {:ok, {current_number, stash_pid}}
  end
  def terminate(_reason, {current_number, stash_pid}) do
    IO.puts "terminate"
    Sequence.Stash.save_value stash_pid, current_number
  end
  def handle_call(:next_number, _from, {current_number, stash_pid}) do
    {:reply, current_number, {current_number + 1, stash_pid}}
  end
  def handle_call({:set_number, new_number}, _from, {_current_number, stash_pid}) do
    {:reply, new_number, {new_number, stash_pid}}
  end

  def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
    {:noreply, {current_number + delta, stash_pid}}
  end

  def format_status(_reaso, [_pdict, state]) do
    [data: [{'State', "My current state is `#{inspect state}`, and I'm happy"}]]
  end
end
