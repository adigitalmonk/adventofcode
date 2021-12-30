defmodule AoC2021.Day1.Part1 do
  def run(filename) do
    filename
    |> load()
    |> process()
  end

  def load(filename) do
    File.stream!(filename)
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.to_integer()
    end)
  end

  def process(items) do
    items
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce(0, fn pair, acc ->
      case pair do
        [a, b] when a < b -> acc + 1
        _ -> acc
      end
    end)
  end
end
