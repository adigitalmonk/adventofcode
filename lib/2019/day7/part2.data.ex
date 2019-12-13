defmodule AoC2019.Day7.Part2.State do
    defstruct [ :ampA, :ampB, :ampC, :ampD, :ampE ]
end

defmodule AoC2019.Day7.Part2.AmpState do
    defstruct [ :data_set, :offset, :output, :input, :fin ]
end
