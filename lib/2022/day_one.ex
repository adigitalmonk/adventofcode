defmodule AoC2022.DayOne do
  import AdventOfCode, only: [data: 1]

  defp organize(filename) do
    filename
    |> data()
    |> Enum.reduce([0], fn
      calories, [current | rest] = acc ->
        calories = String.trim(calories)

        if calories == "",
          do: [0 | acc],
          else: [current + String.to_integer(calories) | rest]
    end)
  end

  def part1(filename \\ "day1.txt") do
    filename
    |> organize()
    |> Enum.max()
  end

  def part2(filename \\ "day1.txt") do
    filename
    |> organize()
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(3)
    |> Enum.sum()
  end
end
