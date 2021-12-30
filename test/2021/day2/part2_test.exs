defmodule AoC2021.Day2.Part1Test do
  use ExUnit.Case

  alias AoC2021.Day2.Part2

  test "operates on the sample data correctly" do
    commands = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]

    assert Part2.process(commands) == 900
  end

  test "operates on the full data set correctly" do
    assert Part2.run("data/2021/day2.txt") == 1_880_593_125
  end
end
