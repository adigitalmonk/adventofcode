defmodule AoC2023.DayTwo do
  import AdventOfCode, only: [data: 1]

  defmodule GameSet do
    defstruct [:game_id, :collection]

    def atomized_color("red"), do: :red
    def atomized_color("green"), do: :green
    def atomized_color("blue"), do: :blue

    def from_raw(input) do
      [<<"Game ", game_id::binary>>, sets] = String.split(input, ": ")
      collection =
        sets
        |> String.split("; ")
        |> Enum.reduce([], fn set_of_marbles, bag_contents ->
          totals =
            set_of_marbles
            |> String.split(", ")
            |> Enum.reduce(%{red: 0, blue: 0, green: 0}, fn marble_count, collection ->
              [count, color] =
                String.split(marble_count, " ")
              color = atomized_color(color)
              count = String.to_integer(count)
              Map.update(collection, color, count, & &1 + count)
            end)

            [ totals | bag_contents ]
        end)

      game_id = String.to_integer(game_id)
      %__MODULE__{ game_id: game_id, collection: collection }
    end

    def impossible?(%__MODULE__{collection: collection}, red, green, blue)
      when is_integer(red)
      when is_integer(blue)
      when is_integer(green)
    do
      Enum.any?(collection, fn marble_set ->
        marble_set[:red] > red ||
        marble_set[:blue] > blue ||
        marble_set[:green] > green
      end)
    end

    def minimum_power(%__MODULE__{collection: collection}) do
      collection
      |> Enum.reduce(%{red: 0, green: 0, blue: 0},
      fn %{red: this_red, green: this_green, blue: this_blue}, %{red: max_red, green: max_green, blue: max_blue} ->
        max_red = if this_red > max_red, do: this_red, else: max_red
        max_blue = if this_blue > max_blue, do: this_blue, else: max_blue
        max_green = if this_green > max_green, do: this_green, else: max_green
        %{ red: max_red, blue: max_blue, green: max_green }
      end)
      |> then(fn %{ red: red, blue: blue, green: green} ->
        red * blue * green
      end)
    end
  end

  def part_one(filename, max_red, max_green, max_blue) do
    filename
    |> data()
    |> Enum.reduce(%{}, fn line, results ->
      game =
        line
        |> String.trim()
        |> GameSet.from_raw()

      Map.put(
        results,
        game.game_id,
        GameSet.impossible?(game, max_red, max_green, max_blue)
      )
    end)
    |> Enum.reduce(0, fn
      {game_id, false}, sum -> sum + game_id
      _, sum -> sum
    end)
  end

  def part_two(filename) do
    filename
    |> data()
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> GameSet.from_raw()
      |> GameSet.minimum_power()
    end)
    |> Enum.sum()
  end
end
