f = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end

fizz_buzz = fn n -> f.(rem(n, 3), rem(n, 5), n) end

Enum.each 10..16, fn n ->
  n |> fizz_buzz.() |> IO.puts
end
