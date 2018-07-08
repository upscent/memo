defmodule Sequence.Server do
  use GenServer

  @name :list_server
  def start_link(list),        do: GenServer.start_link(__MODULE__, list, name: @name)
  def next_number,             do: GenServer.call @name, :next_number
  def set_number(num),         do: GenServer.call @name, {:set_number, num}
  def increment_number(delta), do: GenServer.cast @name, {:increment_number, delta}

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end
  def handle_call({:set_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end
  # iex(1)> {:ok, pid} = GenServer.start_link(Sequence.Server, 100)
  # {:ok, #PID<0.119.0>}
  # iex(2)> GenServer.call(pid, :next_number)
  # 100
  # iex(3)> GenServer.call(pid, :next_number)
  # 101
  # iex(4)> GenServer.call(pid, :next_number)
  # 102
  # iex(5)> GenServer.call(pid, {:set_number, 999})
  # 999
  # iex(6)> GenServer.call(pid, :next_number)
  # 999
  # iex(7)> GenServer.call(pid, :next_number)
  # 1000
  # iex(8)> GenServer.call(pid, :next_number)
  # 1001

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end
  # iex(1)> {:ok, pid} = GenServer.start_link(Sequence.Server, 100)
  # {:ok, #PID<0.127.0>}
  # iex(2)> GenServer.call pid, :next_number
  # 100
  # iex(3)> GenServer.call pid, :next_number
  # 101
  # iex(4)> GenServer.cast pid, {:increment_number, 200}
  # :ok
  # iex(5)> GenServer.call pid, :next_number
  # 302

  def format_status(_reaso, [_pdict, state]) do
    [data: [{'State', "My current state is `#{inspect state}`, and I'm happy"}]]
  end
  # iex(8)> :sys.get_status pid
  # {:status, #PID<0.138.0>, {:module, :gen_server},
  #  [["$initial_call": {Sequence.Server, :init, 1},
  #    "$ancestors": [#PID<0.124.0>, #PID<0.51.0>]], :running, #PID<0.124.0>, [],
  #   [header: 'Status for generic server <0.138.0>',
  #    data: [{'Status', :running}, {'Parent', #PID<0.124.0>},
  #     {'Logged events', []}],
  #    data: [{'State', "My current state is `100`, and I'm happy"}]]]}
end
