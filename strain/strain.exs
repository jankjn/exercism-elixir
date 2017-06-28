defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep([hd | tl], fun) do
    cond do
      fun.(hd) -> [hd | keep(tl, fun)]
      true -> keep(tl, fun)
    end
  end
  def keep([], _fun), do: []

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard([hd | tl], fun) do
    cond do
      fun.(hd) -> discard(tl, fun)
      true -> [hd | discard(tl, fun)]
    end
  end
  def discard([], _fun), do: []
end

