defmodule AoC2019.Day3.Part1 do
  def handle_instruction({"U", 0}, {x, y}, set), do: {{x, y}, set}

  def handle_instruction({"U", distance}, {x, y}, set) do
    new_point = {x, y + 1}
    handle_instruction({"U", distance - 1}, new_point, MapSet.put(set, new_point))
  end

  def handle_instruction({"D", 0}, {x, y}, set), do: {{x, y}, set}

  def handle_instruction({"D", distance}, {x, y}, set) do
    new_point = {x, y - 1}
    handle_instruction({"D", distance - 1}, new_point, MapSet.put(set, new_point))
  end

  def handle_instruction({"R", 0}, {x, y}, set), do: {{x, y}, set}

  def handle_instruction({"R", distance}, {x, y}, set) do
    new_point = {x + 1, y}
    handle_instruction({"R", distance - 1}, new_point, MapSet.put(set, new_point))
  end

  def handle_instruction({"L", 0}, {x, y}, set), do: {{x, y}, set}

  def handle_instruction({"L", distance}, {x, y}, set) do
    new_point = {x - 1, y}
    handle_instruction({"L", distance - 1}, new_point, MapSet.put(set, new_point))
  end

  def manhatten({x, y}) do
    abs(x) + abs(y)
  end

  def parse_instructions(raw_data) do
    [setA, setB] =
      raw_data
      |> String.split()
      |> Enum.map(fn set ->
        String.split(set, ",")
        |> Enum.map(fn <<direction::binary-size(1), rest::binary>> ->
          {direction, String.to_integer(rest)}
        end)
      end)
      |> Enum.map(fn instruction_set ->
        {{_, _}, set} =
          instruction_set
          |> Enum.reduce({{0, 0}, MapSet.new()}, fn instruction, {{x, y}, set} ->
            handle_instruction(instruction, {x, y}, set)
          end)

        set
      end)

    MapSet.intersection(setA, setB)
    |> Enum.map(fn {x, y} = pos ->
      {x, y, manhatten(pos)}
    end)
    |> Enum.sort(fn {_, _, distA}, {_, _, distB} -> distA <= distB end)
    |> hd()
  end

  def run(filename) do
    File.read!(filename)
    |> parse_instructions()
  end
end
