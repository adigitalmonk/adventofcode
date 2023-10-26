defmodule AoC2022.DayTwo do
  import AdventOfCode, only: [data: 1]

  @values %{"X" => 1, "Y" => 2, "Z" => 3}
  @lose 0
  @draw 3
  @win 6

  defp resolve_game(player_a, player_b) do
    base = @values[player_b]

    game_score =
      case {player_a, player_b} do
        # Rock vs. Rock
        {"A", "X"} -> @draw
        # Paper vs. Rock
        {"B", "X"} -> @lose
        # Scissors vs. Rock
        {"C", "X"} -> @win
        # Rock vs. Paper
        {"A", "Y"} -> @win
        # Paper vs. Paper
        {"B", "Y"} -> @draw
        # Scissors vs. Paper
        {"C", "Y"} -> @lose
        # Rock vs. Scissors
        {"A", "Z"} -> @lose
        # Paper vs. Scissors
        {"B", "Z"} -> @win
        # Scissors vs. Scissors
        {"C", "Z"} -> @draw
      end

    base + game_score
  end

  defp base(filename, scorer) do
    filename
    |> data()
    |> Enum.reduce(0, fn
      <<input_a::binary-size(1), " ", input_b::binary-size(1), _rest::binary>>, score ->
        score + scorer.(input_a, input_b)
    end)
  end

  def part1(filename \\ "day2.txt"),
    do: base(filename, &resolve_game/2)

  def desired_outcome(player_a, needed_result) do
    case {player_a, needed_result} do
      # Lose to Rock
      {"A", "X"} -> @lose + @values["Z"]
      # Lose to Paper
      {"B", "X"} -> @lose + @values["X"]
      # Lose to Scissors
      {"C", "X"} -> @lose + @values["Y"]
      # Tie with Rock
      {"A", "Y"} -> @draw + @values["X"]
      # Tie with Paper
      {"B", "Y"} -> @draw + @values["Y"]
      # Tie with Scissors
      {"C", "Y"} -> @draw + @values["Z"]
      # Beat Rock
      {"A", "Z"} -> @win + @values["Y"]
      # Beat Paper
      {"B", "Z"} -> @win + @values["Z"]
      # Beat Scissors
      {"C", "Z"} -> @win + @values["X"]
    end
  end

  def part2(filename \\ "day2.txt"),
    do: base(filename, &desired_outcome/2)
end
