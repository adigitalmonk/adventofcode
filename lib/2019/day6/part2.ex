defmodule AoC2019.Day6.Part2 do
  def build_graph(graph, []), do: graph

  def build_graph(graph, [orbit | rest]) do
    [orbiter, orbitee] = String.split(orbit, ")")

    graph
    |> Graph.add_edge(orbiter, orbitee)
    |> build_graph(rest)
  end

  def build_graph(data_points), do: build_graph(Graph.new(type: :undirected), data_points)

  def run(filename) do
    filename
    |> File.read!()
    |> String.split()
    |> build_graph()
    |> Graph.dijkstra("YOU", "SAN")
  end
end
