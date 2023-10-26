defmodule AoC2022.DayThreeTest do
  use ExUnit.Case, async: true
  alias AoC2022.DayThree

  describe "part one" do
    test "resolves the sample correctly" do
      assert DayThree.part1("2022/day3_sample.txt") == 157
    end

    test "resolves the answer correctly" do
      assert DayThree.part1("2022/day3.txt") == 8202
    end
  end

  describe "part two" do
    test "resolves the sample correctly" do
      assert DayThree.part2("2022/day3_sample.txt") == 70
    end

    test "resolves the answer correctly" do
      assert DayThree.part2("2022/day3.txt") == 2864
    end
  end
end
