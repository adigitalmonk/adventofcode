defmodule AoC2022.DayFour do
  import AdventOfCode, only: [data: 1]

  defp base(filename, logic) do
    filename
    |> data()
    |> Stream.map(fn line ->
      line
      |> String.trim()
      |> String.split(["-", ","], trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(0, logic)
  end

  def part1(filename \\ "day4.txt") do
    filename
    |> base(fn [a, b, x, y], overlaps ->
      cond do
        a <= x && b >= y -> overlaps + 1
        a >= x && b <= y -> overlaps + 1
        true -> overlaps
      end
    end)
  end

  def part2(filename \\ "day4.txt") do
    filename
    |> base(fn [a, b, x, y], overlaps ->
      cond do
        a >= x && a <= y -> overlaps + 1
        b >= x && b <= y -> overlaps + 1
        x >= a && x <= b -> overlaps + 1
        y >= a && y <= b -> overlaps + 1
        true -> overlaps
      end
    end)
  end
end
