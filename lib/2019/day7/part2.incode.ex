defmodule AoC2019.Day7.Part2.Intcode do

    alias AoC2019.Day7.Part2.AmpState

    def get_data("1", data_set, location), do: :array.get(location, data_set)

    def get_data(_, data_set, location),
      do: :array.get(location, data_set) |> :array.get(data_set)

    def consume_instruction(
          <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "01"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do

      param1 = get_data(modeA, data_set, offset + 1)
      param2 = get_data(modeB, data_set, offset + 2)
      target = :array.get(offset + 3, data_set)

      data_set
      |> update_data(target, param1 + param2)
      |> consume_instructions(offset + 4, input, output)
    end

    def consume_instruction(
          <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "02"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do
      param1 = get_data(modeA, data_set, offset + 1)
      param2 = get_data(modeB, data_set, offset + 2)
      target = :array.get(offset + 3, data_set)

      data_set
      |> update_data(target, param1 * param2)
      |> consume_instructions(offset + 4, input, output)
    end

    def consume_instruction(
          <<_::binary-size(1), _::binary-size(1), _::binary-size(1), "03"::binary>>,
          data_set,
          offset,
          [],
          output
        ) do

        %AmpState{
          data_set: data_set,
          input: [],
          offset: offset,
          output: ready_output(output),
          fin: false
        }
    end

    def consume_instruction(
          <<_::binary-size(1), _::binary-size(1), _::binary-size(1), "03"::binary>>,
          data_set,
          offset,
          [this_input | input],
          output
        ) do
      param1 = this_input
      target = :array.get(offset + 1, data_set)

      data_set
      |> update_data(target, param1)
      |> consume_instructions(offset + 2, input, output)
    end

    def consume_instruction(
          <<_::binary-size(1), _::binary-size(1), modeA::binary-size(1), "04"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do
      data_set
      |> consume_instructions(offset + 2, input, [get_data(modeA, data_set, offset + 1) | output])
    end

    def consume_instruction(
          <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "05"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do
      # Opcode 5 is jump-if-true: if the first parameter is non-zero,
      # it sets the instruction pointer to the value from the second parameter.
      # Otherwise, it does nothing.

      param1 = get_data(modeA, data_set, offset + 1)
      param2 = get_data(modeB, data_set, offset + 2)

      if param1 > 0 do
        data_set
        |> consume_instructions(param2, input, output)
      else
        data_set
        |> consume_instructions(offset + 3, input, output)
      end
    end

    def consume_instruction(
          <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "06"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do
      # Opcode 6 is jump-if-false: if the first parameter is zero,
      # it sets the instruction pointer to the value from the second parameter.
      # Otherwise, it does nothing.

      param1 = get_data(modeA, data_set, offset + 1)
      param2 = get_data(modeB, data_set, offset + 2)

      if param1 == 0 do
        data_set
        |> consume_instructions(param2, input, output)
      else
        data_set
        |> consume_instructions(offset + 3, input, output)
      end
    end

    def consume_instruction(
          <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "07"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do
      # Opcode 7 is less than: if the first parameter is less than the second parameter,
      # it stores 1 in the position given by the third parameter.
      # Otherwise, it stores 0.

      param1 = get_data(modeA, data_set, offset + 1)
      param2 = get_data(modeB, data_set, offset + 2)
      target = :array.get(offset + 3, data_set)

      if param1 < param2 do
        data_set
        |> update_data(target, 1)
        |> consume_instructions(offset + 4, input, output)
      else
        data_set
        |> update_data(target, 0)
        |> consume_instructions(offset + 4, input, output)
      end
    end

    def consume_instruction(
          <<_::binary-size(1), modeB::binary-size(1), modeA::binary-size(1), "08"::binary>>,
          data_set,
          offset,
          input,
          output
        ) do
      # Opcode 8 is equals: if the first parameter is equal to the second parameter,
      # it stores 1 in the position given by the third parameter.
      # Otherwise, it stores 0.

      param1 = get_data(modeA, data_set, offset + 1)
      param2 = get_data(modeB, data_set, offset + 2)
      target = :array.get(offset + 3, data_set)

      if param1 == param2 do
        data_set
        |> update_data(target, 1)
        |> consume_instructions(offset + 4, input, output)
      else
        data_set
        |> update_data(target, 0)
        |> consume_instructions(offset + 4, input, output)
      end
    end

    def consume_instruction(
      <<_::binary-size(3), "99"::binary>>,
      data_set,
      _,
      _,
      output
    ) do
      %AmpState{
        data_set: data_set,
        input: [],
        output: ready_output(output),
        fin: true
      }
    end

    def consume_instruction(instruction, data_set, offset) do
      IO.puts("Something went wrong")
      IO.inspect([instruction, offset, :array.to_list(data_set)])
    end

    def consume_instructions(data_set, offset, input, output) do
      :array.get(offset, data_set)
      |> Integer.to_string()
      |> String.pad_leading(5, "0")
      |> consume_instruction(data_set, offset, input, output)
    end

    def run(data_set, offset, input) do
      consume_instructions(data_set, offset, input, [])
    end

    def update_data(arr, index, value), do: :array.set(index, value, arr)

    def ready_output(output) do
      output
      |> Enum.reverse()
      |> Enum.reduce("", fn x, acc ->
        acc <> Integer.to_string(x)
      end)
      |> String.to_integer()
    end

  end
