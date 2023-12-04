defmodule AoC2023.DayOne do
  import AdventOfCode, only: [data: 1]

  def instruction_to_calibration(instruction) do
    found_items =
      ~r/[0-9]/
      |> Regex.scan(instruction)
      |> List.flatten()

    first = found_items |> List.first()
    last = found_items |> List.last()

    (first <> last) |> String.to_integer()
  end

  def part_one(file_name \\ "2023/day1.txt") do
    file_name
    |> data()
    |> Enum.map(fn str ->
      str
      |> String.trim()
      |> instruction_to_calibration()
    end)
    |> Enum.sum()
  end

  def part_two(filename \\ "2023/day1.txt") do
    filename
    |> data()
    |> Enum.map(fn str ->
      str
      |> String.trim()
      |> instruction_to_calibration_part_2()
    end)
    |> IO.inspect()
    |> Enum.sum()
  end

  def instruction_to_calibration_part_2(instruction) do
    first =
      ~r/[0-9]|one|two|three|four|five|six|seven|eight|nine/
      |> Regex.run(instruction)
      |> hd()
      |> representation()

    last =
      ~r/[0-9]|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/
      |> Regex.run( instruction |> String.reverse() )
      |> hd()
      |> String.reverse()
      |> representation()

    (first <> last) |> String.to_integer()
  end


  def representation(input) do
    case input do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
      otherwise -> otherwise
    end
  end

end
