defmodule AoC2019.Day4.Part2 do
  def count_letters(<<>>, map) do
    map
    |> Map.values()
    |> Enum.any?(&(&1 == 2))
  end

  def count_letters(<<letter::binary-size(1), rest::binary>>, map),
    do: count_letters(rest, Map.put(map, letter, (map[letter] || 0) + 1))

  def check_duplicate(
        <<a::binary-size(1), b::binary-size(1), c::binary-size(1), d::binary-size(1),
          e::binary-size(1), f::binary-size(1)>> = input
      ) do
    cond do
      a == b || b == c || c == d || d == e || e == f ->
        count_letters(input, Map.new())

      true ->
        false
    end
  end

  def check_elevation(
        <<a::binary-size(1), b::binary-size(1), c::binary-size(1), d::binary-size(1),
          e::binary-size(1), f::binary-size(1)>>
      ) do
    a <= b && b <= c && c <= d && d <= e && e <= f
  end

  def meets_criteria(step) do
    check_duplicate(step) && check_elevation(step)
  end

  def search(step, last, count) when step > last, do: count

  def search(step, last, count) do
    count =
      if meets_criteria(step) do
        count + 1
      else
        count
      end

    step
    |> String.to_integer()
    |> Kernel.+(1)
    |> Integer.to_string()
    |> search(last, count)
  end

  def search([first, last]), do: search(first, last, 0)

  def run(filename) do
    filename
    |> File.read!()
    |> String.split("-")
    |> search()
  end
end
