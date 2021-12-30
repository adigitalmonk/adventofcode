defmodule AoC2021.Day2.Part1 do
  def run(filename) do
    filename
    |> load()
    |> process()
  end

  def load(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  def process(items) do
    items
    |> Enum.reduce({0, 0}, fn command, {horiz, depth} ->
      case command do
        <<"forward ", delta::binary>> -> {horiz + String.to_integer(delta), depth}
        <<"down ", delta::binary>> -> {horiz, depth + String.to_integer(delta)}
        <<"up ", delta::binary>> -> {horiz, depth - String.to_integer(delta)}
        _ -> {horiz, depth}
      end
    end)
    |> then(fn {h, z} -> h * z end)
  end
end
