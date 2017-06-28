defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    res = []
    if (code &&& 0b1)     != 0, do: res = ["wink" | res]
    if (code &&& 0b10)    != 0, do: res = ["double blink" | res]
    if (code &&& 0b100)   != 0, do: res = ["close your eyes" | res]
    if (code &&& 0b1000)  != 0, do: res = ["jump" | res]
    if (code &&& 0b10000) != 0, do: res = Enum.reverse(res)
    Enum.reverse(res)
  end
end

