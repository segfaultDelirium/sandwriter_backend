defmodule MapMerge do
  def a ||| b do
    Map.merge(a, b)
  end
end
