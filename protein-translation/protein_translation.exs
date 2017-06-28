defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(""), do: { :ok, [] }
  def of_rna(<<condon::binary-size(3), rest_condons::bytes>>) do
    with { :ok, protein } <- of_codon(condon),
         { :ok, rest_proteins } <- of_rna(rest_condons)
    do
      case protein do
        "STOP" -> { :ok, [] }
        _ -> { :ok, [protein | rest_proteins] }
      end
    else
      _ -> { :error, "invalid RNA" }
    end
  end

  @codon_mapping [
      ["UGU", "UGC"]               |> Enum.map(&({ &1, "Cysteine" })),
      ["UUA", "UUG"]               |> Enum.map(&({ &1, "Leucine" })),
      ["AUG"]                      |> Enum.map(&({ &1, "Methionine" })),
      ["UUU", "UUC"]               |> Enum.map(&({ &1, "Phenylalanine" })),
      ["UCU", "UCC", "UCA", "UCG"] |> Enum.map(&({ &1, "Serine" })),
      ["UGG"]                      |> Enum.map(&({ &1, "Tryptophan" })),
      ["UAU", "UAC"]               |> Enum.map(&({ &1, "Tyrosine" })),
      ["UAA", "UAG", "UGA"]        |> Enum.map(&({ &1, "STOP" }))
    ] |> Enum.concat |> Map.new

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case @codon_mapping |> Map.fetch(codon) do
      :error -> { :error, "invalid codon" }
      protein -> protein
    end
  end

end