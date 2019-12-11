defmodule AdventOfCode do
  def run_2019 do
    [
      [AoC2019.Day1.Part1, :run, ["data/day1.txt"]],
      [AoC2019.Day1.Part2, :run, ["data/day1.txt"]],
      [AoC2019.Day2.Part1, :run, ["data/day2.txt"]],
      [AoC2019.Day2.Part2, :run, ["data/day2.txt"]],
      [AoC2019.Day2.Part2.Fast, :run, ["data/day2.txt"]],
      [AoC2019.Day2.Part2.FastArray, :run, ["data/day2.txt"]],
      [AoC2019.Day3.Part1, :run, ["data/day3.txt"]],
      [AoC2019.Day3.Part1.ErlSet, :run, ["data/day3.txt"]],
      [AoC2019.Day3.Part2.Slow, :run, ["data/day3.txt"]],
      [AoC2019.Day4.Part1, :run, ["data/day4.txt"]],
      [AoC2019.Day4.Part2, :run, ["data/day4.txt"]],
      [AoC2019.Day5.Part1, :run, ["data/day5.txt"]],
      [AoC2019.Day5.Part2, :run, ["data/day5.txt"]],
      [AoC2019.Day6.Part1, :run, ["data/day6.txt"]],
    ]
    |> Enum.map(fn [module, function, args] ->
      {exec_time, result} = :timer.tc(module, function, args)

      %{
        module: module |> to_string,
        exec_ms: exec_time / 1_000,
        result: result
      }
    end)
  end
end
