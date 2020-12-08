defmodule AoC2020.Day2.Part2 do
  def run(filename) do
    File.stream!(filename)
    |> Stream.map(&convert_line/1)
    |> Stream.filter(&validate_password/1)
    |> Enum.into([])
    |> Enum.count()
  end

  defp convert_line(line) do
    [first, second, symbol, password] =
      line
      |> String.trim()
      |> String.split([":", " ", "-"], trim: true)

    [
      String.to_integer(first),
      String.to_integer(second),
      symbol,
      password
    ]
  end

  defp validate_password([first, second, symbol, password]) do
    parts = String.graphemes(password)
    first_match = Enum.at(parts, first - 1) == symbol
    second_match = Enum.at(parts, second - 1) == symbol

    case {first_match, second_match} do
      {true, false} -> true
      {false, true} -> true
      _ -> false
    end
  end
end
