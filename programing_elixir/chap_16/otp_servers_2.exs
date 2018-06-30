defmodule ListServer do
  use GenServer

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

# iex(3)> c "otp_servers_2.exs"
# [ListServer]
# iex(4)> {:ok, pid} = GenServer.start_link ListServer, [5, "cat", 9]
# {:ok, #PID<0.93.0>}
# iex(5)> GenServer.call pid, :pop
# 5
# iex(6)> GenServer.call pid, :pop
# "cat"
# iex(7)> GenServer.cast pid, {:push, "dog"}
# :ok
# iex(8)> GenServer.call pid, :pop
# "dog"
# iex(9)> GenServer.call pid, :pop
# 9
# iex(10)> GenServer.call pid, :pop
# nil
# iex(11)> GenServer.cast pid, {:push, 10}
# :ok
# iex(12)> GenServer.call pid, :pop
# 10
