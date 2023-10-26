defmodule AoC2020.Day4.Part1 do
  import AdventOfCode, only: [data: 1]

  def run(filename) do
    filename
    |> data()
    |> Enum.into("")
    |> String.split("\n")
    |> batch_load()
    |> Enum.count(&validate_password/1)
  end

  def batch_load(raw, data \\ "", collection \\ [])

  def batch_load([], _, collection), do: collection

  def batch_load([details], data, collection) do
    batch_load([], "", [parse_passport(data <> " " <> details) | collection])
  end

  def batch_load(["" | tail], data, collection) do
    batch_load(tail, "", [parse_passport(data) | collection])
  end

  def batch_load([details | tail], data, collection) do
    batch_load(tail, data <> " " <> details, collection)
  end

  def parse_passport(data) do
    data
    |> String.split(" ", trim: true)
    |> Enum.reduce(%{}, fn <<key::binary-size(3), ":", value::binary>>, acc ->
      Map.put(acc, key, value)
    end)
  end

  def validate_password(passport) do
    [
      Map.has_key?(passport, "byr"),
      Map.has_key?(passport, "iyr"),
      Map.has_key?(passport, "eyr"),
      Map.has_key?(passport, "hgt"),
      Map.has_key?(passport, "hcl"),
      Map.has_key?(passport, "ecl"),
      Map.has_key?(passport, "pid")
    ]
    |> Enum.all?(& &1)
  end
end
