defmodule AoC2021.Day3.Part1 do
  def run(filename) do
    filename
    |> load()

    # |> process()
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

  # def process(items) do
  #   items
  #   |> Enum.reduce(%{}, fn item, counts ->
  #     String.split()
  #     |> Enum.with_index(&{&1, &1})
  #     |> Enum.reduce(counts, fn {item, index}, acc ->
  #       nil
  #       # Map.update(counts,)
  #     end)
  #   end)
  # end
end
