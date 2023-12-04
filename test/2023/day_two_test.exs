defmodule AoC2023.DayTwoTest do
  use ExUnit.Case, async: true
  alias AoC2023.DayTwo

  describe "Part One" do
    test "correct sample value" do
      assert DayTwo.part_one("2023/day2.sample.txt", 12, 13, 14) == 8
    end

    test "correct real value" do
      assert DayTwo.part_one("2023/day2.txt", 12, 13, 14) == 2348
    end
  end

  describe "Part Two" do
    test "correct sample value" do
      assert DayTwo.part_two("2023/day2.sample.txt") == 2286
    end

    test "correct real value" do
      assert DayTwo.part_two("2023/day2.txt") == 76008
    end
  end
end
