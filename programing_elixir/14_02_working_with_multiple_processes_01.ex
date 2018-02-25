# Sample code
defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    1..n
    |> Enum.reduce(self(), fn (_, send_to) -> spawn(__MODULE__, :counter, [send_to]) end)
    |> send(0)

    receive do
      answer when is_integer(answer) -> "Result is #{inspect answer}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(__MODULE__, :create_processes, [n])
  end
end

# upscent@mbp-upscent ~/workspace/github_upscent/memo/programing_elixir
# % elixir --erl "+P 1000000" -r 14_02_working_with_multiple_processes_01.ex -e "Chain.run(400_000)"
# {3193504, "Result is 400000"}
# upscent@mbp-upscent ~/workspace/github_upscent/memo/programing_elixir
# % elixir --erl "+P 1000000" -r 14_02_working_with_multiple_processes_01.ex -e "Chain.run(1_000_000)"
# {9833180, "Result is 1000000"}
