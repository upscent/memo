defmodule WorkingWithMultipleProcesses3 do
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
    exit(:boom)
  end
end

WorkingWithMultipleProcesses3.run

# upscent@mbp-upscent ~/workspace/github_upscent/memo/programing_elixir/14_03
# % elixir -r working_with_multiple_process_3.exs
# ** (EXIT from #PID<0.70.0>) :boom
