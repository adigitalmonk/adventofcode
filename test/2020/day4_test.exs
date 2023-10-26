defmodule AoC2020.Day4Test do
  use ExUnit.Case

  test "day 4 / part 1" do
    assert AoC2020.Day4.Part1.run("2020/day4.txt") == 242
  end

  test "day 4 / part 2" do
    assert AoC2020.Day4.Part2.run("2020/day4.txt") == 186
  end
end
