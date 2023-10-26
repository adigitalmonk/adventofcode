defmodule AoC2021.Day1.Part1Test do
  use ExUnit.Case
  alias AoC2021.Day1.Part1

  test "counts the example increases correctly" do
    items = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert Part1.process(items) == 7
  end

  test "runs the sample data correctly" do
    assert Part1.run("2021/day1.txt") == 1301
  end
end
