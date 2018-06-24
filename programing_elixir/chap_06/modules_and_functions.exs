defmodule Times do
  def double(i), do: 2 * i

  #-----------------------
  # ModulesAndFunctions-1
  #-----------------------
  def triple(i), do: 3 * i

  #-----------------------
  # ModulesAndFunctions-3
  #-----------------------
  def quadruple(i), do: i |> double |> double
end

defmodule ModulesAndFunctions do
  #-----------------------
  # ModulesAndFunctions-4
  #-----------------------
  def sum(n) when n < 1, do: 0
  def sum(n),            do: n + sum(n - 1)

  #-----------------------
  # ModulesAndFunctions-5
  #-----------------------
  def gcd(x, 0), do: x
  def gcd(0, y), do: y
  def gcd(x, y), do: gcd(y, rem(x, y))

  #-----------------------
  # ModulesAndFunctions-6
  #-----------------------
  def guess(actual, actual..actual), do: actual
  def guess(actual, first..last) when first <= actual and actual <= last do
    avg = div(first + last, 2)
    IO.puts "Is it #{avg}?"
    cond do
      actual === avg -> actual
      actual > avg   -> guess(actual, (avg + 1)..last)
      actual < avg   -> guess(actual, first..(avg - 1))
    end
  end
end
