defmodule WorkingWithMultipleProcesses3 do
  def run(method) do
    spawn_monitor(__MODULE__, method, [self()])
    :timer.sleep 500
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect(msg)}"
    after 1000 ->
        IO.puts "Nothing happend as far as I am concerned"
    end
  end
  def suddenly_exit(parent) do
    send parent, "hoge"
    exit(:boom)
  end
  def suddenly_raise(parent) do
    send parent, "hoge"
    raise :boom
  end
end

WorkingWithMultipleProcesses3.run(:suddenly_exit)
WorkingWithMultipleProcesses3.run(:suddenly_raise)

# upscent@mbp-upscent ~/workspace/github_upscent/memo/programing_elixir/14_03
# % elixir -r working_with_multiple_process_5.exs
# MESSAGE RECEIVED: "hoge"
