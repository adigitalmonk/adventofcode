defmodule AoC2020.Day3Test do
  use ExUnit.Case

  test "day 3 / part 1" do
    assert AoC2020.Day3.Part1.run("2020/day3.txt") == 268
  end

  test "day 3 / part 2" do
    assert AoC2020.Day3.Part2.run("2020/day3.txt") == 3_093_068_400
  end
end
