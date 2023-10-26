defmodule AoC2020.Day2.Part1 do
  import AdventOfCode, only: [data: 1]

  def run(filename) do
    filename
    |> data()
    |> Stream.map(&convert_line/1)
    |> Stream.filter(&validate_password/1)
    |> Enum.into([])
    |> Enum.count()
  end

  defp convert_line(line) do
    [lower, upper, symbol, password] =
      line
      |> String.trim()
      |> String.split([":", " ", "-"], trim: true)

    [
      String.to_integer(lower),
      String.to_integer(upper),
      symbol,
      password
    ]
  end

  defp validate_password([lower, upper, symbol, password]) do
    instances =
      password
      |> String.split(symbol)
      |> Enum.count()
      |> Kernel.-(1)

    if instances >= lower && instances <= upper, do: true, else: false
  end
end
