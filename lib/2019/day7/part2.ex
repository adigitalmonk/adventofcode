defmodule AoC2019.Day7.Part2 do
  import AdventOfCode, only: [data: 1]

  alias AoC2019.Day7.Part2.Intcode
  alias AoC2019.Day7.Part2.State
  alias AoC2019.Day7.Part2.AmpState

  def run_amp(
        %State{
          ampA: %AmpState{fin: true},
          ampB: %AmpState{fin: true},
          ampC: %AmpState{fin: true},
          ampD: %AmpState{fin: true},
          ampE: %AmpState{fin: true, output: output}
        },
        _
      ) do
    output
  end

  def run_amp(
        %State{
          ampE: %AmpState{
            data_set: data_set,
            offset: offset,
            input: input
          },
          ampA: %AmpState{input: inputB} = ampA
        } = data,
        4
      ) do
    %AmpState{output: step_output} = step_state = Intcode.run(data_set, offset, input)
    new_input = inputB ++ [step_output]

    run_amp(%State{data | ampE: step_state, ampA: %AmpState{ampA | input: new_input}}, 0)
  end

  def run_amp(
        %State{
          ampD: %AmpState{
            data_set: data_set,
            offset: offset,
            input: input
          },
          ampE: %AmpState{input: inputB} = ampE
        } = data,
        3
      ) do
    %AmpState{output: step_output} = step_state = Intcode.run(data_set, offset, input)
    new_input = inputB ++ [step_output]

    run_amp(%State{data | ampD: step_state, ampE: %AmpState{ampE | input: new_input}}, 4)
  end

  def run_amp(
        %State{
          ampC: %AmpState{
            data_set: data_set,
            offset: offset,
            input: input
          },
          ampD: %AmpState{input: inputB} = ampD
        } = data,
        2
      ) do
    %AmpState{output: step_output} = step_state = Intcode.run(data_set, offset, input)
    new_input = inputB ++ [step_output]

    run_amp(%State{data | ampC: step_state, ampD: %AmpState{ampD | input: new_input}}, 3)
  end

  def run_amp(
        %State{
          ampB: %AmpState{
            data_set: data_set,
            offset: offset,
            input: input
          },
          ampC: %AmpState{input: inputB} = ampC
        } = data,
        1
      ) do
    %AmpState{output: step_output} = step_state = Intcode.run(data_set, offset, input)
    new_input = inputB ++ [step_output]

    run_amp(%State{data | ampB: step_state, ampC: %AmpState{ampC | input: new_input}}, 2)
  end

  def run_amp(
        %State{
          ampA: %AmpState{
            data_set: data_set,
            offset: offset,
            input: input
          },
          ampB: %AmpState{input: inputB} = ampB
        } = data,
        0
      ) do
    %AmpState{output: step_output} = step_state = Intcode.run(data_set, offset, input)
    new_input = inputB ++ [step_output]

    run_amp(%State{data | ampA: step_state, ampB: %AmpState{ampB | input: new_input}}, 1)
  end

  def run(filename) do
    data_set =
      filename
      |> data()
      |> Enum.into("")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> :array.from_list()

    Permutations.perms([5, 6, 7, 8, 9])
    # |> Enum.map(fn phase_seq ->
    #   output =
    #     get_initial_state(data_set, phase_seq)
    #     |> run_amp(0)

    #   { output, phase_seq }
    # end)
    # |> Enum.max_by(fn { output, _ } -> output end)
    |> Task.async_stream(fn phase_seq ->
      output =
        get_initial_state(data_set, phase_seq)
        |> run_amp(0)

      {output, phase_seq}
    end)
    |> Enum.into([])
    |> Enum.max_by(fn {:ok, {output, _}} -> output end)
  end

  def get_initial_state(init_data, [a, b, c, d, e]) do
    %State{
      ampA: %AmpState{data_set: init_data, output: 0, offset: 0, input: [a, 0], fin: false},
      ampB: %AmpState{data_set: init_data, output: 0, offset: 0, input: [b], fin: false},
      ampC: %AmpState{data_set: init_data, output: 0, offset: 0, input: [c], fin: false},
      ampD: %AmpState{data_set: init_data, output: 0, offset: 0, input: [d], fin: false},
      ampE: %AmpState{data_set: init_data, output: 0, offset: 0, input: [e], fin: false}
    }
  end
end
