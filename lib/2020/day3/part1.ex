defmodule AoC2020.Day3.Part1 do
  def run(filename) do
    filename
    |> File.stream!()
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.split("", trim: true)
      |> Stream.cycle()
    end)
    |> route(3, 1)
  end

  def route(map, right, down, x \\ 0, collisions \\ 0) do
    case Enum.drop(map, down) do
      [] ->
        collisions

      [head | _] = map ->
        movement = x + right

        collision? =
          head
          |> Stream.drop(movement)
          |> Stream.take(1)
          |> Enum.into([])
          |> List.first()
          |> collision?()

        route(
          map,
          right,
          down,
          movement,
          if(collision?, do: collisions + 1, else: collisions)
        )
    end
  end

  defp collision?("#"), do: true
  defp collision?(_), do: false
end
