defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(fn
      c when c in ?A..?Z -> rem(c + shift - ?A, 26) + ?A
      c when c in ?a..?z -> rem(c + shift - ?a, 26) + ?a
      c -> c
    end)
    |> to_string
  end
end

