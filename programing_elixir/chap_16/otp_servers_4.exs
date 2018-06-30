defmodule ListServer do
  use GenServer

  @name :list_server
  def start_link(list), do: GenServer.start_link(__MODULE__, list, name: @name)
  def pop,              do: GenServer.call @name, :pop
  def push(elem),       do: GenServer.cast @name, {:push, elem}

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end
  def handle_cast({:push, elem}, list) do
    {:noreply, [elem | list]}
  end
end

# iex(1)> c "otp_servers_4.exs"
# [ListServer]
# iex(2)> ListServer.start_link [5, "cat", 9]
# {:ok, #PID<0.88.0>}
# iex(3)> ListServer.pop
# 5
# iex(4)> ListServer.pop
# "cat"
# iex(5)> ListServer.push "dog"
# :ok
# iex(6)> ListServer.pop
# "dog"
# iex(7)> ListServer.pop
# 9
# iex(8)> ListServer.pop
# nil
