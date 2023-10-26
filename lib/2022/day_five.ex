defmodule AoC2022.DayFive do
  import AdventOfCode, only: [data: 1]

  defp build_stacks(stacks, piles \\ [])
  defp build_stacks([_tail], piles), do: Enum.reverse(piles)

  defp build_stacks([head | tail], piles) do
    <<_drop::binary-size(1), rest::binary>> = head

    parts =
      rest
      |> String.split("", trim: true)
      |> Enum.chunk_every(1, 4)

    build_stacks(tail, [parts | piles])
  end

  defp base(filename) do
    [stacks, instructions] =
      filename
      |> data()
      |> Stream.map(fn input -> String.trim_trailing(input, "\n") end)
      |> Enum.reduce([[]], fn input, [head | rest] = items ->
        if input == "" do
          [[] | items]
        else
          head = [input | head]
          [head | rest]
        end
      end)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.reverse()

    piles =
      build_stacks(stacks)

    [piles | instructions]
  end

  def part1(filename \\ "day5.txt") do
    filename
    |> base()
  end

  def part2(_filename \\ "day5.txt") do
    # filename
    # |> base()
    # |>

    false
  end
end
