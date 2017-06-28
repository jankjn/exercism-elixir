defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(&multiples(limit, &1))
    |> Enum.concat
    |> MapSet.new
    |> Enum.sum
  end

  def multiples(limit, factor) when limit <= factor, do: []
  def multiples(limit, factor), do: 1..div(limit - 1, factor) |> Enum.map(&(&1 * factor))
end
