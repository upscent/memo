defmodule Stack do
  use GenServer

  @name :list_server
  def start_link(list), do: GenServer.start_link(__MODULE__, list, name: @name)
  def pop,              do: GenServer.call @name, :pop
  def push(elem),       do: GenServer.cast @name, {:push, elem}
  def terminate(n),     do: GenServer.cast @name, {:terminate, n}

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
  def handle_cast({:push, elem}, list) do
    {:noreply, [elem | list]}
  end
  def handle_cast({:terminate, n}, list) do
    IO.puts "list: #{inspect(list)}"
    System.stop(n)
    {:noreply, list}
  end
end
