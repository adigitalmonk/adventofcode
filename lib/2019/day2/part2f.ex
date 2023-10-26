defmodule AoC2019.Day2.Part2.Fast do
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
        data_set |> hd()

      _ ->
        data_set |> hd()
    end
  end

  def run_iteration(data_set, noun, verb) do
    data_set
    |> List.update_at(1, fn _ -> noun end)
    |> List.update_at(2, fn _ -> verb end)
    |> consume_instructions()
  end

  def run(filename) do
    instructions =
      filename
      |> data()
      |> Enum.into("")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {:ok, {noun, verb, _}} =
      0..99
      |> Stream.flat_map(fn
        noun -> Stream.map(0..99, &{noun, &1})
      end)
      |> Task.async_stream(fn {noun, verb} ->
        {noun, verb, run_iteration(instructions, noun, verb)}
      end)
      |> Enum.find(fn {:ok, {_noun, _verb, result}} ->
        result == 19_690_720
      end)

    100 * noun + verb
  end
end
