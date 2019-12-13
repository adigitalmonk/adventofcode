defmodule AoC2019.Day7.Part2 do
    alias AoC2019.Day7.Part2.Intcode
    alias AoC2019.Day7.Part2.Data
    alias AoC2019.Day7.Part2.Amplifier

    def run_amplifier(phase_seq, %Data{} = data, 4) do

        run_amplifer(data, 0)
    end

    def run_amplifier(phase_seq, %Data{} = data, 3) do

        run_amplifer(data, 4)
    end

    def run_amplifier(phase_seq, %Data{} = data, 2) do

        run_amplifer(data, 3)
    end

    def run_amplifier(phase_seq, %Data{} = data, 1) do

        run_amplifer(data, 2)
    end

    def run_amplifier(phase_seq, %Data{} = data, 0) do

        run_amplifer(data, 1)
    end

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
        { data_setA, offsetA, output } = Intcode.run(data_set, [a, 0])
        # Amp B
        { data_set, offset + 1, output } = Intcode.run(data_set, [b, output])
        # Amp C
        { data_set, offset + 1, output } = Intcode.run(data_set, [c, output])
        # Amp D
        { data_set, offset + 1, output } = Intcode.run(data_set, [d, output])
        # Amp E
        { data_set, offset + 1, output } = Intcode.run(data_set, [e, output])
  
        {output, phase_seq}
      end)
      |> Enum.max_by(fn {output, _} -> output end)
    end
  end
  