defmodule AoC2019.Day3.Part2 do

    def handle_instruction({ "U", distance }, { x, y }) do
        { x, y + distance }
    end

    def handle_instruction({ "D", distance }, { x, y }) do
        { x, y - distance }
    end

    def handle_instruction({ "R", distance }, { x, y }) do
        { x + distance, y }
    end

    def handle_instruction({ "L", distance }, { x, y }) do
        { x - distance, y }
    end

    def parse_instructions(raw_data) do
        raw_data
        |> String.split()
        |> Enum.map(fn set -> 
            String.split(set, ",")
            |> Enum.map(fn << direction::binary-size(1), rest::binary >> -> 
                { direction, String.to_integer(rest) }
            end)
        end)
        |> Enum.map(fn instruction_set -> 
            instruction_set
            |> Enum.reduce({{0, 0}, {0, 0}}, fn instruction, { start , term } -> 
                { start, handle_instruction(instruction, start) }
            end)
        end)
        |> IO.inspect
    end

    def run(filename) do
        File.read!(filename)
        |> parse_instructions()
    end
end
