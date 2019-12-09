defmodule AoC2019.Day5.Part2 do
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
    param3 = :array.get(offset + 3, data_set)

    data_set
    |> update_data(param3, param1 + param2)
    |> consume_instructions(offset + 4)
  end

  def consume_instruction(
        <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "02"::binary>>,
        data_set,
        offset
      ) do
    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)
    param3 = :array.get(offset + 3, data_set)

    data_set
    |> update_data(param3, param1 * param2)
    |> consume_instructions(offset + 4)
  end

  def consume_instruction(
        <<_::binary-size(1), _::binary-size(1), _::binary-size(1), "03"::binary>>,
        data_set,
        offset
      ) do
    param1 =
      IO.gets("Input: ")
      |> String.trim()
      |> String.to_integer()

    param2 = :array.get(offset + 1, data_set)

    data_set
    |> update_data(param2, param1)
    |> consume_instructions(offset + 2)
  end

  def consume_instruction(
        <<_::binary-size(1), _::binary-size(1), _::binary-size(1), "04"::binary>>,
        data_set,
        offset
      ) do
    param1 = :array.get(offset + 1, data_set)

    :array.get(param1, data_set)
    |> IO.puts()

    consume_instructions(data_set, offset + 2)
  end

  def consume_instruction(
        <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "05"::binary>>,
        data_set,
        offset
      ) do
    # Opcode 5 is jump-if-true: if the first parameter is non-zero,
    # it sets the instruction pointer to the value from the second parameter.
    # Otherwise, it does nothing.

    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)

    if param1 > 0 do
      data_set
      |> consume_instructions(param2)
    else
      data_set
      |> consume_instructions(offset + 2)
    end
  end

  def consume_instruction(
        <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "06"::binary>>,
        data_set,
        offset
      ) do
    # Opcode 6 is jump-if-false: if the first parameter is zero,
    # it sets the instruction pointer to the value from the second parameter.
    # Otherwise, it does nothing.

    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)

    if param1 == 0 do
      data_set
      |> consume_instructions(param2)
    else
      data_set
      |> consume_instructions(offset + 2)
    end
  end

  def consume_instruction(
        <<modeC::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "07"::binary>>,
        data_set,
        offset
      ) do
    # Opcode 7 is less than: if the first parameter is less than the second parameter,
    # it stores 1 in the position given by the third parameter.
    # Otherwise, it stores 0.

    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)
    param3 = get_data(modeC, data_set, offset + 3)

    if param1 < param2 do
      data_set
      |> update_data(param3, 1)
      |> consume_instructions(offset + 2)
    else
      data_set
      |> update_data(param3, 0)
      |> consume_instructions(offset + 2)
    end
  end

  def consume_instruction(
        <<modeC::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "08"::binary>>,
        data_set,
        offset
      ) do
    # Opcode 8 is equals: if the first parameter is equal to the second parameter,
    # it stores 1 in the position given by the third parameter.
    # Otherwise, it stores 0.

    param1 = get_data(modeA, data_set, offset + 1)
    param2 = get_data(modeB, data_set, offset + 2)
    param3 = get_data(modeC, data_set, offset + 3)

    if param1 == param2 do
      data_set
      |> update_data(param3, 1)
      |> consume_instructions(offset + 2)
    else
      data_set
      |> update_data(param3, 0)
      |> consume_instructions(offset + 2)
    end
  end

  def consume_instruction(
        <<_::binary-size(1), _::binary-size(1), _::binary-size(1), "99"::binary>>,
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
