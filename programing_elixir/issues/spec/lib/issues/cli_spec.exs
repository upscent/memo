defmodule Issues.CLISpec do
  use ESpec, async: true
  let :header, do: ~w{a b c d e}
  let :rows, do: [%{"b" => 1, "c" => 22, "d" => 333, "e" => 4444, "a" => ""}]
  let :printable_rows, do: [["", "1", "22", "333", "4444"]]
  let :widths, do: [1, 1, 2, 3, 4]

  describe "convert_to_list_of_maps/1" do
    subject(Issues.CLI.convert_to_list_of_maps(list_of_keywordlist()))
    let :list_of_keywordlist, do: [[a: 1, b: 2], [c: 3, d: 4]]
    it do: should(eq [%{a: 1, b: 2}, %{c: 3, d: 4}])
  end

  describe "convert_to_printable_values/2" do
    subject(Issues.CLI.convert_to_printable_values(rows(), header()))
    it do: should(eq printable_rows())
  end

  describe "print_table/3" do
    subject(Issues.CLI.print_table(printable_rows(), header()))
    it do
      capture_io(fn -> subject() end)
      |> expect()
      |> to(eq """
      a | b |  c |   d |    e
      --+---+----+-----+-----
        | 1 | 22 | 333 | 4444
      """)
    end
  end

  describe "_max_widths_of_column/2" do
    subject(Issues.CLI._max_widths_of_column(printable_rows(), header()))
    it do: should(eq widths())
  end
end
