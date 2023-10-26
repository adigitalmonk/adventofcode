defmodule AoC2019.Day1.Part2 do
  import AdventOfCode, only: [data: 1]

  defp fuel_for(component) do
    component
    |> div(3)
    |> Kernel.-(2)
  end

  def fuel_for_fuel(fuel, weight \\ 0)
  def fuel_for_fuel(fuel, 0) when fuel > 0, do: fuel_for_fuel(fuel, fuel)

  def fuel_for_fuel(fuel, weight) do
    fuel = fuel_for(fuel)

    cond do
      fuel > 0 ->
        fuel_for_fuel(fuel, weight + fuel)

      true ->
        weight
    end
  end

  def calculate(components, weight \\ 0)
  def calculate([], weight), do: weight

  def calculate([component | components], weight) do
    total_fuel =
      fuel_for(component)
      |> fuel_for_fuel()

    calculate(components, weight + total_fuel)
  end

  def run(filename) do
    filename
    |> data()
    |> Enum.map(fn input ->
      input
      |> String.trim()
      |> String.to_integer()
    end)
    |> calculate()
  end
end
