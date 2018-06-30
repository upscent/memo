defmodule ListServer do
  use GenServer

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
end

# iex(1)> c "otp_servers_1.exs"
# [ListServer]
# iex(2)> {:ok, pid} = GenServer.start_link ListServer, [5, "cat", 9]
# {:ok, #PID<0.88.0>}
# iex(3)> GenServer.call pid, :pop
# 5
# iex(4)> GenServer.call pid, :pop
# "cat"
# iex(5)> GenServer.call pid, :pop
# 9
# iex(6)> GenServer.call pid, :pop
# ** (EXIT from #PID<0.80.0>) an exception was raised:
#     ** (FunctionClauseError) no function clause matching in ListServer.handle_call/3
#         otp_servers_1.exs:4: ListServer.handle_call(:pop, {#PID<0.80.0>, #Reference<0.0.4.463>}, [])
#         (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
#         (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
#         (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
#
# Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)>
# 01:46:43.662 [error] GenServer #PID<0.88.0> terminating
# ** (FunctionClauseError) no function clause matching in ListServer.handle_call/3
#     otp_servers_1.exs:4: ListServer.handle_call(:pop, {#PID<0.80.0>, #Reference<0.0.4.463>}, [])
#     (stdlib) gen_server.erl:615: :gen_server.try_handle_call/4
#     (stdlib) gen_server.erl:647: :gen_server.handle_msg/5
#     (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# Last message: :pop
# State: []
