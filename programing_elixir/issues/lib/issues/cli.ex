defmodule Issues.CLI do
  @default_count 4
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    argv
    |> OptionParser.parse(switches: [ help: :boolean ], aliases: [ h: :help ])
    |> case do
      {[ help: true ], _, _} -> :help
      {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
      {_, [user, project],        _} -> {user, project, @default_count}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end
  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_maps
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> print_table(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, :message, 0)
    IO.puts "Error fetching from Gituhb: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_maps(list) do
    IO.puts """
    convert_to_list_of_maps
    """
    list |> Enum.map(&Enum.into(&1, Map.new))
  end

  def sort_into_ascending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 -> i1["created_at"] <= i2["created_at"] end)
  end

  def print_table(rows, columns) do
    printable_rows = take_printable_values(rows, columns)
    widths = max_widths_of_column(printable_rows, columns)
    print(printable_rows, columns, widths)
  end

  def take_printable_values(rows, columns) do
    for r <- rows, do: for c <- columns, do: convert_to_printable_value(r[c])
  end

  def convert_to_printable_value(v) when is_binary(v), do: v
  def convert_to_printable_value(v) when is_integer(v), do: Integer.to_string(v)
  def convert_to_printable_value(v), do: raise RuntimeError, message: "can not convert #{v} to string."

  def max_widths_of_column(printable_rows, columns) do
    columns
    |> Enum.with_index()
    |> Enum.map(fn {column, index} ->
      [column | Enum.map(printable_rows, &(Enum.fetch!(&1, index)))]
      |> Enum.map(&String.length/1)
      |> Enum.max
    end)
  end

  @delimiter " | "
  def print(printable_rows, columns, widths) do
    print_row(columns, widths)
    IO.puts String.duplicate("-", Enum.sum(widths) + (length(columns) - 1) * String.length(@delimiter))
    Enum.each(printable_rows, &(print_row(&1, widths)))
  end

  def print_row(printable_row, widths) do
    Enum.zip(printable_row, widths)
    |> Enum.map(fn {row, width} -> String.pad_leading(row, width) end)
    |> Enum.join(@delimiter)
    |> IO.puts
    :defalut
  end
end
