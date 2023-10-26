defmodule AoC2019.Day2.Part2.FastArray do
  import AdventOfCode, only: [data: 1]

  def consume_instructions(data_set, offset \\ 0) do
    [a, b, c, d] = [
      :array.get(offset, data_set),
      :array.get(offset + 1, data_set),
      :array.get(offset + 2, data_set),
      :array.get(offset + 3, data_set)
    ]

    case a do
      1 ->
        update_data(data_set, d, :array.get(b, data_set) + :array.get(c, data_set))
        |> consume_instructions(offset + 4)

      2 ->
        update_data(data_set, d, :array.get(b, data_set) * :array.get(c, data_set))
        |> consume_instructions(offset + 4)

      99 ->
        :array.get(0, data_set)

      _ ->
        :array.get(0, data_set)
    end
  end

  def update_data(arr, index, value), do: :array.set(index, value, arr)

  def run_iteration(data_set, noun, verb) do
    data_set
    |> update_data(1, noun)
    |> update_data(2, verb)
    |> consume_instructions()
  end

  def run(filename) do
    instructions =
      filename
      |> data()
      |> Enum.into("")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> :array.from_list()

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
