defmodule AoC2020.Day3.Part2 do
  alias AoC2020.Day3.Part1

  def run(filename) do
    filename
    |> File.stream!()
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.split("", trim: true)
      |> Stream.cycle()
    end)
    |> find_product()
  end

  def find_product(map) do
    [
      Part1.route(map, 1, 1),
      Part1.route(map, 3, 1),
      Part1.route(map, 5, 1),
      Part1.route(map, 7, 1),
      Part1.route(map, 1, 2)
    ]
    |> Enum.reduce(1, &(&1 * &2))
  end
end
