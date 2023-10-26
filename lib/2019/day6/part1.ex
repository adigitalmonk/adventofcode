defmodule AoC2019.Day6.Part1 do
  import AdventOfCode, only: [data: 1]

  def build_graph(graph, []), do: graph

  def build_graph(graph, [orbit | rest]) do
    [orbiter, orbitee] = String.split(orbit, ")")

    graph
    |> Graph.add_edge(orbiter, orbitee)
    |> build_graph(rest)
  end

  def build_graph(data_points), do: build_graph(Graph.new(), data_points)

  def find_relations(root, graph) do
    Graph.Reducers.Bfs.reduce(graph, 0, fn
      node, acc ->
        case Graph.dijkstra(graph, root, node) do
          nil -> {:next, acc}
          path -> {:next, acc + Enum.count(path) - 1}
        end
    end)
  end

  def run(filename) do
    graph =
      filename
      |> data()
      |> Enum.into("")
      |> String.split()
      |> build_graph()

    graph
    |> Graph.topsort()
    |> hd()
    |> find_relations(graph)
  end
end
