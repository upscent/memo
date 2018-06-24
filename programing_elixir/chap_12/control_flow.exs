defmodule ControlFlow do
  #-----------------------
  # Controlflow-1
  #-----------------------
  def fizzbuzz_upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

  defp fizzbuzz(n) do
    case [rem(n, 3), rem(n, 5)] do
      [0, 0] -> "FizzBuzz"
      [0, _] -> "Fizz"
      [_, 0] -> "Buzz"
      _      -> n
    end
  end

  #-----------------------
  # Controlflow-2
  #-----------------------
  def ok!({:ok, data}), do: data
  def ok!({:error, message}), do: raise RuntimeError, message: "#{message}"
  def ok!({status, message}), do: raise RuntimeError, message: "uknown status: #{status}, message: #{message}"
end
