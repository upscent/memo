defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  @default_count 4
  @delimiter " | "
  @delimiter_for_border "-+-"

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
    header = ["number", "created_at", "title"]

    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_maps
    |> Enum.sort_by(&(&1["created_at"]))
    |> Enum.take(count)
    |> convert_to_printable_values(header)
    |> print_table(header)
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, :message, 0)
    IO.puts "Error fetching from Gituhb: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_maps(list) do
    list |> Enum.map(&Enum.into(&1, Map.new))
  end

  def print_table(printable_rows, header) do
    widths = _max_widths_of_column(printable_rows, header)

    _print_row(header, widths)
    widths
    |> Enum.map(&(String.duplicate("-", &1)))
    |> _print_row(widths, @delimiter_for_border)
    Enum.each(printable_rows, &(_print_row(&1, widths)))
  end

  def convert_to_printable_values(rows, header) do
    for r <- rows, do: for c <- header, do: _convert_to_printable_value(r[c])
  end
  def _convert_to_printable_value(v) when is_binary(v), do: v
  def _convert_to_printable_value(v) when is_integer(v), do: Integer.to_string(v)
  def _convert_to_printable_value(v), do: raise RuntimeError, message: "can not convert #{inspect(v)} to string."

  def _max_widths_of_column(printable_rows, header) do
    [ header | printable_rows ]
    |> Enum.zip()
    |> Enum.map(fn col ->
      col |> Tuple.to_list() |> Enum.map(&String.length/1) |> Enum.max()
    end)
  end

  def _print_row(printable_row, widths, delimiter \\ @delimiter) do
    Enum.zip(printable_row, widths)
    |> Enum.map(fn {row, width} -> String.pad_trailing(row, width) end)
    |> Enum.join(delimiter)
    |> IO.puts()
  end
end
