defmodule AoC2019.Day7.Part1 do
  alias AoC2019.Day7.Part1.Intcode

  def run(filename) do
    data_set =
      filename
      |> File.read!()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> :array.from_list()

    Permutations.perms([0, 1, 2, 3, 4])
    |> Enum.map(fn [a, b, c, d, e] = phase_seq ->
      # Amp A
      output = Intcode.run(data_set, [a, 0])
      # Amp B
      output = Intcode.run(data_set, [b, output])
      # Amp C
      output = Intcode.run(data_set, [c, output])
      # Amp D
      output = Intcode.run(data_set, [d, output])
      # Amp E
      output = Intcode.run(data_set, [e, output])

      {output, phase_seq}
    end)
    |> Enum.max_by(fn {output, _} -> output end)
  end
end
