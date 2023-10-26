defmodule AoC2019.Day1.Part1 do
  import AdventOfCode, only: [data: 1]

  def run(filename) do
    filename
    |> data()
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(0, fn x, acc ->
      y =
        x
        |> String.trim()
        |> String.to_integer()
        |> div(3)

      acc + (y - 2)
    end)
  end
end
