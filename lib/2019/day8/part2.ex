defmodule AoC2019.Day8.Part2 do
  def compile_line([], [], new_line), do: Enum.reverse(new_line)

  def compile_line([2 | rest], [fhead | frest], new_line) do
    compile_line(rest, frest, [fhead | new_line])
  end

  def compile_line([head | rest], [_ | frest], new_line) do
    compile_line(rest, frest, [head | new_line])
  end

  def compile_layer([], [], new_layer), do: Enum.reverse(new_layer)

  def compile_layer([line | rest], [fline | frest], new_layer) do
    compile_layer(rest, frest, [compile_line(line, fline, []) | new_layer])
  end

  def compile_layers([], final), do: final

  def compile_layers([layer | rest], final) do
    compile_layers(rest, compile_layer(layer, final, []))
  end

  def compile_layers([first | rest]) do
    compile_layers(rest, first)
  end

  def run(filename) do
    filename
    |> File.read!()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(25)
    |> Enum.chunk_every(6)
    |> Enum.reverse()
    |> compile_layers()
    |> draw_layer()
  end

  def draw_layer([]), do: nil

  def draw_layer([line | rest]) do
    draw_line(line)
    draw_layer(rest)
  end

  @one "#"
  @zero " "

  def draw_line([1]), do: IO.puts(@one)
  def draw_line([0]), do: IO.puts(@zero)

  def draw_line([1 | rest]) do
    IO.write(@one)
    draw_line(rest)
  end

  def draw_line([0 | rest]) do
    IO.write(@zero)
    draw_line(rest)
  end
end
