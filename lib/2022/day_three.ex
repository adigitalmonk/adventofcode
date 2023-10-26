defmodule AoC2022.DayThree do
  import AdventOfCode, only: [data: 1]

  defp score(<<item::utf8, _rest::binary>>) do
    case item do
      item when item in ?a..?z -> item - ?a + 1
      item when item in ?A..?Z -> item - ?A + 27
    end
  end

  defp load(filename) do
    filename
    |> data()
    |> Stream.map(fn sack ->
      sack
      |> String.trim()
      |> String.split("", trim: true)
    end)
  end

  def part1(filename \\ "day3.txt") do
    filename
    |> load()
    |> Enum.reduce(0, fn sack, priority ->
      compartment_size = div(Enum.count(sack), 2)

      item_score =
        sack
        |> Enum.chunk_every(compartment_size)
        |> then(fn [left, right] ->
          Enum.find(left, fn li -> li in right end)
        end)
        |> score()

      priority + item_score
    end)
  end

  def part2(filename \\ "day3.txt") do
    filename
    |> load()
    |> Stream.chunk_every(3)
    |> Enum.reduce(0, fn [sack1, sack2, sack3], priority ->
      item_score =
        Enum.find(sack1, fn i1 -> i1 in sack2 and i1 in sack3 end)
        |> score()

      priority + item_score
    end)
  end
end
