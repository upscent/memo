defmodule Ticker do
  @interval 2000 # 2 seconds
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end
  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end
  def generator(clients, next_client \\ nil) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        next_client = case next_client do
          nil -> pid
          _   -> next_client
        end
        generator([pid|clients], next_client)
      { :stop } ->
        Enum.each(clients, fn client -> send client, { :stop } end)
    after
        @interval ->
          IO.puts "tick"
          next_client =
            case next_client do
              nil -> next_client
              _   ->
                send next_client, { :tick }

                idx = Enum.find_index(clients, &(&1 == next_client))
                case idx do
                0 -> List.last(clients)
                _ -> Enum.at(clients, idx - 1)
                end
            end
          generator(clients, next_client)
    end
  end
  def stop do
    send :global.whereis_name(@name), { :stop }
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end
  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client #{inspect(self())}"
        receiver()
      { :stop } ->
        IO.puts "bye #{inspect(self())}"
        nil
    end
  end
end
