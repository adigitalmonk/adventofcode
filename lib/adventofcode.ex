defmodule AdventOfCode do
  def run(modules) do
    modules
    |> Enum.each(fn [module, function, args] ->
      {exec_time, result} = :timer.tc(module, function, args)

      IO.inspect(%{
        module: module |> to_string,
        exec_ms: exec_time / 1_000,
        result: result
      })
    end)
  end

  def run_2019 do
    [
      [AoC2019.Day1.Part1, :run, ["data/2019/day1.txt"]],
      [AoC2019.Day1.Part2, :run, ["data/2019/day1.txt"]],
      [AoC2019.Day2.Part1, :run, ["data/2019/day2.txt"]],
      [AoC2019.Day2.Part2, :run, ["data/2019/day2.txt"]],
      [AoC2019.Day2.Part2.Fast, :run, ["data/2019/day2.txt"]],
      [AoC2019.Day2.Part2.FastArray, :run, ["data/2019/day2.txt"]],
      [AoC2019.Day3.Part1, :run, ["data/2019/day3.txt"]],
      [AoC2019.Day3.Part1.ErlSet, :run, ["data/2019/day3.txt"]],
      [AoC2019.Day3.Part2.Slow, :run, ["data/2019/day3.txt"]],
      [AoC2019.Day4.Part1, :run, ["data/2019/day4.txt"]],
      [AoC2019.Day4.Part2, :run, ["data/2019/day4.txt"]],
      [AoC2019.Day5.Part1, :run, ["data/2019/day5.txt"]],
      [AoC2019.Day5.Part2, :run, ["data/2019/day5.txt"]],
      [AoC2019.Day6.Part1, :run, ["data/2019/day6.txt"]],
      [AoC2019.Day6.Part2, :run, ["data/2019/day6.txt"]],
      [AoC2019.Day7.Part1, :run, ["data/2019/day7.txt"]],
      [AoC2019.Day7.Part2, :run, ["data/2019/day7.txt"]]
    ]
    |> run()
  end

  def run_2020 do
    [
      [AoC2020.Day1.Part1, :run, ["data/2020/day1.txt"]],
      [AoC2020.Day1.Part2, :run, ["data/2020/day1.txt"]],
      [AoC2020.Day2.Part1, :run, ["data/2020/day2.txt"]],
      [AoC2020.Day2.Part2, :run, ["data/2020/day2.txt"]],
      [AoC2020.Day3.Part1, :run, ["data/2020/day3.txt"]],
      [AoC2020.Day3.Part2, :run, ["data/2020/day3.txt"]]
    ]
    |> run()
  end
end
