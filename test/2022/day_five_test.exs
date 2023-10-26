defmodule AoC2022.DayFiveTest do
  use ExUnit.Case, async: true
  alias AoC2022.DayFive

  describe "part one" do
    @tag :skip
    test "resolves the sample correctly" do
      assert DayFive.part1("2022/day5_sample.txt") == 0
    end

    @tag :skip
    test "resolves the answer correctly" do
      assert DayFive.part1("2022/day5.txt") == 0
    end
  end

  describe "part two" do
    @tag :skip
    test "resolves the sample correctly" do
      assert DayFive.part2("2022/day5_sample.txt") == 4
    end

    @tag :skip
    test "resolves the answer correctly" do
      assert DayFive.part2("2022/day5.txt") == 830
    end
  end
end
