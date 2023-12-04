defmodule AoC2023.DayOneTest do
  use ExUnit.Case, async: true
  alias AoC2023.DayOne

  describe "Part One" do
    test "correct sample value" do
      assert DayOne.part_one("2023/day1.sample.txt") == 142
    end

    test "correct real value" do
      assert DayOne.part_one("2023/day1.txt") == 53921
    end
  end

  describe "Part Two" do
    test "correct sample value" do
      assert DayOne.part_two("2023/day1.sample2.txt") == 281
    end

    test "correct real value" do
      assert DayOne.part_two("2023/day1.txt") == 0
    end
  end
end
