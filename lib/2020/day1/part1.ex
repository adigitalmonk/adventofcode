defmodule AoC2020.Day1.Part1 do
  def run(filename) do
    File.stream!(filename)
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.to_integer()
    end)
    |> find_match()
    |> combine()
  end

  def find_match(numbers) do
    Enum.reduce_while(numbers, -1, fn first, acc ->
      case Enum.find(numbers, &(&1 + first == 2020)) do
        nil ->
          {:cont, acc}

        second ->
          {:halt, {first, second}}
      end
    end)
  end

  def combine({first, second}) do
    first * second
  end
end
