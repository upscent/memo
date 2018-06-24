f = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end

IO.puts f.(0,0,1)
IO.puts f.(0,1,2)
IO.puts f.(1,0,2)
IO.puts f.(1,2,3)
