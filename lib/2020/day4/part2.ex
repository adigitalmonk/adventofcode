defmodule AoC2020.Day4.Part2 do
  alias AoC2020.Day4.Part1

  def run(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Part1.batch_load()
    |> Enum.count(&validate_password/1)
  end

  def validate_password(passport) do
    [
      validate_field(passport, :byr),
      validate_field(passport, :iyr),
      validate_field(passport, :eyr),
      validate_field(passport, :hgt),
      validate_field(passport, :hcl),
      validate_field(passport, :ecl),
      validate_field(passport, :pid)
    ]
    |> Enum.all?(& &1)
  end

  def validate_field(%{"pid" => field}, :pid),
    do: String.match?(field, ~r/^[0-9]{9}$/)

  def validate_field(%{"ecl" => field}, :ecl),
    do: String.match?(field, ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/)

  def validate_field(%{"hcl" => field}, :hcl),
    do: String.match?(field, ~r/^\#([0-9]|[a-f]){6}$/)

  def validate_field(%{"hgt" => field}, :hgt) do
    case String.match?(field, ~r/.*(cm|in)$/) do
      false ->
        false

      true ->
        case Integer.parse(field) do
          {value, "cm"} -> value >= 150 && value <= 193
          {value, "in"} -> value >= 59 && value <= 76
          _ -> false
        end
    end
  end

  def validate_field(%{"byr" => field}, :byr),
    do: number_in_range(field, 1920, 2002)

  def validate_field(%{"iyr" => field}, :iyr),
    do: number_in_range(field, 2010, 2020)

  def validate_field(%{"eyr" => field}, :eyr),
    do: number_in_range(field, 2020, 2030)

  def validate_field(_, _), do: false

  def number_in_range(number, lower, upper) do
    case Integer.parse(number) do
      {value, ""} -> value >= lower && value <= upper
      _ -> false
    end
  end
end
