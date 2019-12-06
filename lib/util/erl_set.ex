defmodule Util.ErlSet do
  def new do
    :sets.new()
  end

  def add(set, element) do
    :sets.add_element(element, set)
  end

  def intersect(set1, set2) do
    :sets.intersection(set1, set2)
  end

  def to_list(set) do
    :sets.to_list(set)
  end
end
