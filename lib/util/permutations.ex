# https://stackoverflow.com/questions/34357121/permutations-in-elixir
defmodule Permutations do
  def perms(%MapSet{} = set),
    do: MapSet.to_list(set) |> perms

  def perms([]), do: [[]]

  def perms(l) do
    for h <- l, t <- perms(l -- [h]), do: [h | t]
  end
end
