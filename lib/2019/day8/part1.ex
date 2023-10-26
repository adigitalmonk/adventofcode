defmodule AoC2019.Day8.Part1 do
  import AdventOfCode, only: [data: 1]

  def count_numbers(layers, target, sum \\ 0)
  def count_numbers([], _, sum), do: sum

  def count_numbers([layer | rest], target, sum) do
    layer_sum =
      layer
      |> Enum.count(fn datum -> datum == target end)

    count_numbers(rest, target, sum + layer_sum)
  end

  def check_sum(image_data) do
    zero_data =
      image_data
      |> Enum.map(&count_numbers(&1, 0))

    lowest =
      zero_data
      |> Enum.min()

    lowest_layer_id =
      zero_data
      |> Enum.find_index(fn
        val -> val == lowest
      end)

    lowest_layer =
      image_data
      |> Enum.at(lowest_layer_id)

    ones = count_numbers(lowest_layer, 1)
    twos = count_numbers(lowest_layer, 2)

    ones * twos
  end

  def run(filename) do
    filename
    |> data()
    |> Enum.into("")
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(25)
    |> Enum.chunk_every(6)
    |> check_sum()
  end
end
