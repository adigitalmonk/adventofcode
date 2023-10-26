defmodule AoC2021.Day2.Part1Test do
  use ExUnit.Case

  alias AoC2021.Day2.Part1

  test "operates on the sample data correctly" do
    commands = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]

    assert Part1.process(commands) == 150
  end

  test "operates on the full data set correctly" do
    assert Part1.run("2021/day2.txt") == 1_507_611
  end
end
