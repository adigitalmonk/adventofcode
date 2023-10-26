defmodule AoC2019.Day2.Part2 do
  import AdventOfCode, only: [data: 1]

  def consume_instructions(data_set, offset \\ 0) do
    [a, b, c, d] = [
      Enum.at(data_set, offset),
      Enum.at(data_set, offset + 1),
      Enum.at(data_set, offset + 2),
      Enum.at(data_set, offset + 3)
    ]

    case a do
      1 ->
        List.update_at(data_set, d, fn _ -> Enum.at(data_set, b) + Enum.at(data_set, c) end)
        |> consume_instructions(offset + 4)

      2 ->
        List.update_at(data_set, d, fn _ -> Enum.at(data_set, b) * Enum.at(data_set, c) end)
        |> consume_instructions(offset + 4)

      99 ->
        data_set

      _ ->
        data_set
    end
  end

  def find_answer(instructions, noun \\ 0, verb \\ 0)

  def find_answer(_instructions, 100, _), do: nil
  def find_answer(instructions, noun, 100), do: find_answer(instructions, noun + 1, 0)

  def find_answer(instructions, noun, verb) do
    iteration =
      instructions
      |> List.update_at(1, fn _ -> noun end)
      |> List.update_at(2, fn _ -> verb end)

    case consume_instructions(iteration) do
      [19_690_720 | _] ->
        100 * noun + verb

      _ ->
        find_answer(instructions, noun, verb + 1)
    end
  end

  def run(filename) do
    instructions =
      filename
      |> data()
      |> Enum.into("")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    instructions
    |> find_answer()
  end
end
