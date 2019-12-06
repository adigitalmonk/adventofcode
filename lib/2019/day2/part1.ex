defmodule AoC2019.Day2.Part1 do
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

  def run(filename) do
    File.read!(filename)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> consume_instructions()
    |> hd()
  end
end
