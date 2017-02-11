defmodule ListAndRecursion do
  #-----------------------
  # ListAndRecursion-0
  #-----------------------
  def sum([]), do: 0
  def sum([value | list]) do
    value + sum(list)
  end

  def reduce(value, [], _f), do: value
  def reduce(value, [first | list], func), do: reduce(func.(value, first), list, func)

  #-----------------------
  # ListAndRecursion-1
  #-----------------------
  def mapsum(list, func), do: do_mapsum(list, 0, func)
  defp do_mapsum([], result, _f), do: result
  defp do_mapsum([head | list], result, func), do: do_mapsum(list, func.(head) + result, func)

  #-----------------------
  # ListAndRecursion-2
  #-----------------------
  def max(list), do: do_max(list, nil)
  defp do_max([], value), do: value
  defp do_max([head | list], nil),                     do: do_max(list, head)
  defp do_max([head | list], value) when head > value, do: do_max(list, head)
  defp do_max([_    | list], value),                   do: do_max(list, value)

  #-----------------------
  # ListAndRecursion-3
  #-----------------------
  def caesar(string, n), do: do_caesar(string, n, [])
  defp do_caesar([], _, value), do: value
  defp do_caesar([head | tail], n, value) do
    char = rem((head + n) - ?a, ?z - ?a + 1) + ?a
    do_caesar(tail, n, value ++ [char])
  end

  #-----------------------
  # ListAndRecursion-4
  #-----------------------
  def span(from, to), do: do_span(from, to, [])
  def do_span(from, from, list), do: list ++ [from]
  def do_span(from, to,   list), do: do_span(from + 1, to, list ++ [from])

  #-----------------------
  # ListAndRecursion-5
  #-----------------------
  def all?([], _), do: true
  def all?([head | tail], fnc), do: fnc.(head) && all?(tail, fnc)

  def each([], _), do: :ok
  def each([head | tail], fnc) do
    fnc.(head)
    each(tail, fnc)
  end

  def filter(list, fnc), do: do_filter(list, [], fnc)
  defp do_filter([], filtered_list, _), do: filtered_list
  defp do_filter([head | tail], filtered_list, fnc) do
    next_filtered_list = case fnc.(head) do
      true -> filtered_list ++ [head]
      false -> filtered_list
    end
    do_filter(tail, next_filtered_list, fnc)
  end

  def split(list, count) when count < 0, do: do_split([], list, length(list) + count)
  def split(list, count),                do: do_split([], list, count)
  defp do_split(head, [], _), do: { head, [] }
  defp do_split(head, tail, count) when length(head) >= count, do: { head, tail }
  defp do_split(head, [h | tail], count), do: do_split(head ++ [h], tail, count)

  def take(list, count) do
    {head, tail} = split(list, count)
    cond do
      count < 0 -> tail
      true      -> head
    end
  end

  #-----------------------
  # ListAndRecursion-6
  #-----------------------
  def flatten(list) when is_list(list), do: do_flatten(list, [])
  defp do_flatten([], flatten_list), do: flatten_list
  defp do_flatten([h | t], flatten_list) when is_list(h),
    do: do_flatten(t, flatten_list ++ do_flatten(h, []))
  defp do_flatten([h | t], flatten_list),
    do: do_flatten(t, flatten_list ++ [h])

  #-----------------------
  # ListAndRecursion-7
  #-----------------------
  def primes(n) do
    for i <- span(2, n), prime?(i), do: i
  end

  def prime?(n) when n == 2, do: true
  def prime?(n) when n > 2 do
    max = n |> :math.sqrt |> Float.ceil |> round
    span(2, max)
    |> Enum.all?(&(rem(n, &1) > 0))
  end

  #-----------------------
  # ListAndRecursion-8
  #-----------------------
  @tax_rates [
    NC: 0.075,
    TX: 0.08,
  ]
  def add_tax(list) do
    for item <- list do
      tax_rate = Keyword.get(@tax_rates, item[:ship_to], 0)
      total_amount = item[:net_amount] + (1 + tax_rate)
      [ {:total_amount, total_amount} | item ]
    end
  end
end
