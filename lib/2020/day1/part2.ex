defmodule AoC2020.Day1.Part2 do
  import AdventOfCode, only: [data: 1]

  def run(filename) do
    filename
    |> data()
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.to_integer()
    end)
    |> find_match()
    |> combine()
  end

  def find_match(numbers) do
    Enum.reduce_while(numbers, -1, fn first, _ ->
      Enum.reduce_while(numbers, -1, fn second, _ ->
        Enum.find(numbers, &(first + second + &1 == 2020))
        |> case do
          nil ->
            {:cont, {:cont, -1}}

          third ->
            {:halt, {:halt, {first, second, third}}}
        end
      end)
    end)
  end

  def combine({first, second, third}) do
    first * second * third
  end
end
