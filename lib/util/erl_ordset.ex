defmodule Util.Erl.OrdSet do
  def new do
    :ordsets.new()
  end

  def add(set, element) do
    :ordsets.add_element(element, set)
  end

  def intersect(set1, set2) do
    :ordsets.intersection(set1, set2)
  end

  def to_list(set) do
    :ordsets.to_list(set)
  end
end
