defmodule Receiver do
  def create(n \\ 2) do
    current = self()
    1..n
    |> Enum.map(fn _ -> spawn(__MODULE__, :bounce, [current]) end)
    |> Enum.with_index()
    |> Enum.map(fn {child, i} ->
      send child, {current, "process#{i}"}
      child
    end)
  end

  def bounce(parent) do
    receive do
      {^parent, token} ->
        :timer.sleep :rand.uniform(5)
        send parent, {self(), token}
    end
  end
end

defmodule Caller do
  def wait_sync([]), do: nil
  def wait_sync([child | children]) do
    receive do
      {^child, token} ->
        IO.puts("received token `#{token}`.")
        wait_sync(children)
    end
  end

  def wait_async([]), do: nil
  def wait_async([_ | children]) do
    receive do
      {_, token} -> IO.puts("received token `#{token}`.")
    end
    wait_async(children)
  end
end

IO.puts "---- wait async ---"
10
|> Receiver.create
|> Caller.wait_async

IO.puts "---- wait sync ---"
10
|> Receiver.create
|> Caller.wait_sync
