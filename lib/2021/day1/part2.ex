defmodule AoC2021.Day1.Part2 do
  alias AoC2021.Day1.Part1

  def run(filename) do
    filename
    |> Part1.load()
    |> process()
  end

  def process(items) do
    items
    |> Enum.chunk_every(3, 1)
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce(0, fn triplet, acc ->
      case triplet do
        [[a, b, c], [b, c, d]] when a < d -> acc + 1
        _ -> acc
      end
    end)
  end
end
