defmodule Scrabble do

  @scores [
    String.graphemes("AEIOULNRST") |> Enum.map(&({ &1, 1 })),
    String.graphemes("DG")         |> Enum.map(&({ &1, 2 })),
    String.graphemes("BCMP")       |> Enum.map(&({ &1, 3 })),
    String.graphemes("FHVWY")      |> Enum.map(&({ &1, 4 })),
    String.graphemes("K")          |> Enum.map(&({ &1, 5 })),
    String.graphemes("JX")         |> Enum.map(&({ &1, 8 })),
    String.graphemes("QZ")         |> Enum.map(&({ &1, 10 })),
  ] |> Enum.concat |> Enum.into(%{})

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.graphemes
    |> Enum.map(&Map.get(@scores, &1, 0))
    |> Enum.sum
  end
end
