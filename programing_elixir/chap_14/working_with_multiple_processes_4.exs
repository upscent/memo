defmodule WorkingWithMultipleProcesses4 do
  def run do
    spawn_link(__MODULE__, :suddenly_stop, [self()])
    :timer.sleep 500
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect(msg)}"
    after 1000 ->
        IO.puts "Nothing happend as far as I am concerned"
    end
  end
  def suddenly_stop(parent) do
    send parent, "hoge"
    raise "bye-bye"
  end
end

WorkingWithMultipleProcesses4.run

# upscent@mbp-upscent ~/workspace/github_upscent/memo/programing_elixir/14_03
# % elixir -r working_with_multiple_process_4.exs
# ** (EXIT from #PID<0.70.0>) an exception was raised:
#     ** (RuntimeError) bye-bye
#         working_with_multiple_process_4.exs:14: WorkingWithMultipleProcesses4.suddenly_stop/1
#
# 19:35:56.228 [error] Process #PID<0.76.0> raised an exception
# ** (RuntimeError) bye-bye
#     working_with_multiple_process_4.exs:14: WorkingWithMultipleProcesses4.suddenly_stop/1
