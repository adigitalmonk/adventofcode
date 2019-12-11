defmodule AoC2019.Day5.Part1 do
  def get_data("1", data_set, location), do: :array.get(location, data_set)

  def get_data(_, data_set, location),
    do: :array.get(location, data_set) |> :array.get(data_set)

  def consume_instruction(
        <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "01"::binary>>,
        data_set,
        offset
      ) do
    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)
    target = :array.get(offset + 3, data_set)

    data_set
    |> update_data(target, param1 + param2)
    |> consume_instructions(offset + 4)
  end

  def consume_instruction(
        <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "02"::binary>>,
        data_set,
        offset
      ) do
    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)
    target = :array.get(offset + 3, data_set)

    data_set
    |> update_data(target, param1 * param2)
    |> consume_instructions(offset + 4)
  end

  def consume_instruction(
        <<_::binary-size(1), _::binary-size(1), _::binary-size(1), "03"::binary>>,
        data_set,
        offset
      ) do
    param1 = 1
    # IO.gets("Input: ")
    # |> String.trim()
    # |> String.to_integer()

    target = :array.get(offset + 1, data_set)

    data_set
    |> update_data(target, param1)
    |> consume_instructions(offset + 2)
  end

  def consume_instruction(
        <<_::binary-size(1), _::binary-size(1), modeA::binary-size(1), "04"::binary>>,
        data_set,
        offset
      ) do
    get_data(modeA, data_set, offset + 1)
    |> IO.puts()

    consume_instructions(data_set, offset + 2)
  end

  def consume_instruction(
        <<_::binary-size(3), "99"::binary>>,
        data_set,
        _
      ) do
    :array.get(0, data_set)
  end

  def consume_instruction(instruction, data_set, offset) do
    IO.puts("Something went wrong")
    IO.inspect([instruction, offset, :array.to_list(data_set)])
  end

  def consume_instructions(data_set, offset \\ 0) do
    :array.get(offset, data_set)
    |> Integer.to_string()
    |> String.pad_leading(5, "0")
    |> consume_instruction(data_set, offset)
  end

  def update_data(arr, index, value), do: :array.set(index, value, arr)

  def run(filename) do
    File.read!(filename)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> :array.from_list()
    |> consume_instructions()
  end
end
