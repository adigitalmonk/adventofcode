defmodule AoC2021.Day3.Part1 do
  def run(filename) do
    filename
    |> load()
    |> process()
  end

  def load(filename) do
    filename
    |> File.stream!()
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.to_integer(2)
    end)
  end

  def process(_items) do
    # TODO
  end
end
