defmodule AoC2019.Day1.Part1 do
  def run(filename) do
    File.stream!(filename)
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(0, fn x, acc ->
      y =
        x
        |> String.trim()
        |> String.to_integer()
        |> div(3)

      acc + (y - 2)
    end)
  end
end
