defmodule AoC2019.Day6.Part2 do
  import AdventOfCode, only: [data: 1]

  def build_graph(graph, []), do: graph

  def build_graph(graph, [orbit | rest]) do
    [orbiter, orbitee] = String.split(orbit, ")")

    graph
    |> Graph.add_edge(orbiter, orbitee)
    |> Graph.add_edge(orbitee, orbiter)
    |> build_graph(rest)
  end

  def build_graph(data_points), do: build_graph(Graph.new(), data_points)

  def run(filename) do
    filename
    |> data()
    |> Enum.into("")
    |> String.split()
    |> build_graph()
    |> Graph.dijkstra("YOU", "SAN")
    |> Enum.count()
    # Remove "YOU" and "SAN", remove one more since we want the points between
    |> Kernel.-(3)
  end
end
