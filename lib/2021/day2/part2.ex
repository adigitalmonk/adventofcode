defmodule AoC2021.Day2.Part2 do
  alias AoC2021.Day2.Part1

  def run(filename) do
    filename
    |> Part1.load()
    |> process()
  end

  def process(items) do
    items
    |> Enum.reduce({0, 0, 0}, fn command, {horiz, depth, aim} ->
      case command do
        <<"forward ", delta::binary>> ->
          delta = String.to_integer(delta)
          {horiz + delta, depth + aim * delta, aim}

        <<"down ", delta::binary>> ->
          delta = String.to_integer(delta)
          {horiz, depth, aim + delta}

        <<"up ", delta::binary>> ->
          delta = String.to_integer(delta)
          {horiz, depth, aim - delta}

        _ ->
          {horiz, depth, aim}
      end
    end)
    |> then(fn {h, z, _a} -> h * z end)
  end
end
