defmodule AoC2019.Day5.Part1 do

    def consume_instruction(instruction, data_set, offset) do

    end

  def consume_instructions(data_set, offset \\ 0) do
    [a, b, c, d] = [
      :array.get(offset, data_set),
      :array.get(offset + 1, data_set),
      :array.get(offset + 2, data_set),
      :array.get(offset + 3, data_set)
    ]

    case :array.get(offset, data_set) do
      1 ->
        [b, c, d] = [
          :array.get(offset + 1, data_set),
          :array.get(offset + 2, data_set),
          :array.get(offset + 3, data_set)
        ]

        update_data(data_set, d, :array.get(b, data_set) + :array.get(c, data_set))
        |> consume_instructions(offset + 4)

      2 ->
        [b, c, d] = [
          :array.get(offset + 1, data_set),
          :array.get(offset + 2, data_set),
          :array.get(offset + 3, data_set)
        ]

        update_data(data_set, d, :array.get(b, data_set) * :array.get(c, data_set))
        |> consume_instructions(offset + 4)

      3 ->
        [b, c] = [
          :array.get(offset + 1, data_set),
          :array.get(offset + 2, data_set)
        ]

        update_data(data_set, c, b)
        |> consume_instructions(offset + 3)

      4 ->
        [b, c] = [
          :array.get(offset + 1, data_set),
          :array.get(offset + 2, data_set)
        ]

        IO.puts(:array.get(c, data_set))
        consume_instructions(offset + 3)

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
      File.read!(filename)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> :array.from_list()
      |> consume_instructions()
  end
end
