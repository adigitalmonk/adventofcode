defmodule AoC2019.Day3.Part2.Slow do
  import AdventOfCode, only: [data: 1]

  def handle_instruction({"U", 0}, {x, y}, arr), do: {{x, y}, arr}

  def handle_instruction({"U", distance}, {x, y}, arr) do
    new_point = {x, y + 1}
    handle_instruction({"U", distance - 1}, new_point, [new_point | arr])
  end

  def handle_instruction({"D", 0}, {x, y}, arr), do: {{x, y}, arr}

  def handle_instruction({"D", distance}, {x, y}, arr) do
    new_point = {x, y - 1}
    handle_instruction({"D", distance - 1}, new_point, [new_point | arr])
  end

  def handle_instruction({"R", 0}, {x, y}, arr), do: {{x, y}, arr}

  def handle_instruction({"R", distance}, {x, y}, arr) do
    new_point = {x + 1, y}
    handle_instruction({"R", distance - 1}, new_point, [new_point | arr])
  end

  def handle_instruction({"L", 0}, {x, y}, arr), do: {{x, y}, arr}

  def handle_instruction({"L", distance}, {x, y}, arr) do
    new_point = {x - 1, y}
    handle_instruction({"L", distance - 1}, new_point, [new_point | arr])
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
        {{_, _}, arr} =
          instruction_set
          |> Enum.reduce({{0, 0}, []}, fn instruction, {{x, y}, arr} ->
            handle_instruction(instruction, {x, y}, arr)
          end)

        Enum.reverse(arr)
      end)

    raw_data
    |> AoC2019.Day3.Part1.parse_instructions()
    |> Enum.map(fn {find_x, find_y, _} ->
      [x, y] = [
        Enum.find_index(setA, fn {x, y} ->
          x == find_x && y == find_y
        end) + 1,
        Enum.find_index(setB, fn {x, y} ->
          x == find_x && y == find_y
        end) + 1
      ]

      x + y
    end)
    |> Enum.sort()
    |> hd()
  end

  def run(filename) do
    filename
    |> data()
    |> Enum.into("")
    |> parse_instructions()
  end
end
