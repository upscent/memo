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

# iex(1)> c "otp_servers_3.exs"
# [ListServer]
# iex(2)> {:ok, pid} = GenServer.start_link ListServer, [5, "cat", 9], name: :list_server
# {:ok, #PID<0.88.0>}
# iex(3)> GenServer.call :list_server, :pop
# 5
# iex(4)> GenServer.call :list_server, :pop
# "cat"
