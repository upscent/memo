defmodule StringsAndBinaries do
  require ListAndRecursion # for StringsAndBinaries-7

  #-----------------------
  # StringsAndBinaries-1
  #-----------------------
  def string?([]), do: true
  def string?([head | _]) when head < ?\s, do: false
  def string?([head | _]) when head > ?~, do: false
  def string?([_ | tail]), do: string?(tail)

  #-----------------------
  # StringsAndBinaries-2
  #-----------------------
  def anagram?(word1, word2) when is_list(word1) and is_list(word2) do
    Enum.sort(word1) == Enum.sort(word2)
  end

  #-----------------------
  # StringsAndBinaries-4
  #-----------------------
  def calculate(string) do
    [num1, op, num2] = split_by_space(string)
    case op do
      '+' -> number(num1) + number(num2)
      '-' -> number(num1) - number(num2)
      op  -> raise "Invalid Operator: #{op}"
    end
  end

  def split_by_space(string), do: _split_by_space(string, '', [])
  defp _split_by_space([], string, string_list),
    do: string_list ++ [string]
  defp _split_by_space([?\s | tail], string, string_list),
    do: _split_by_space(tail, '', string_list ++ [string])
  defp _split_by_space([char | tail], string, string_list),
    do: _split_by_space(tail, string ++ [char], string_list)

  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str), do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value) when digit in '0123456789',
    do: _number_digits(tail, value * 10 + digit - ?0)
  defp _number_digits([ non_digit | _ ], _),
    do: raise "Invalid digit '#{[non_digit]}'"

  #-----------------------
  # StringsAndBinaries-5
  #-----------------------
  def center(list) do
    max_length =
      list
      |> Enum.map(&String.length/1)
      |> Enum.max
    _print_centering(list, max_length)
  end
  defp _print_centering([], _), do: nil
  defp _print_centering([head | tail], size) do
    spaces = String.duplicate(" ", div(size - String.length(head), 2))
    IO.puts(spaces <> head)
    _print_centering(tail, size)
  end

  #-----------------------
  # StringsAndBinaries-6
  #-----------------------
  def capitalize_sentences(str) do
    str
    |> String.split(". ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(". ")
  end

  #-----------------------
  # StringsAndBinaries-7
  #-----------------------
  def read_sales_infomation! do
    File.open!("./sample_string_and_binaries_7.csv", [:read], fn(f) ->
      IO.read(f, :line) # ヘッダーは捨てる
      f
      |> IO.stream(:line)
      |> Enum.map(&__MODULE__.format_line/1)
      |> ListAndRecursion.add_tax
    end)
  end
  def format_line(line) do
    [id, ship_to, net_amount] = line |> String.strip |> String.split(",")
    [
      id: String.to_integer(id),
      ship_to: ship_to |> String.replace(":", "") |> String.to_atom,
      net_amount: String.to_float(net_amount)
    ]
  end
end
