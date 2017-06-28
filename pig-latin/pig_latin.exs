defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&translate_one/1)
    |> Enum.join(" ")
  end

  def translate_one(phrase) do
    <<a::binary-size(1), b::binary-size(1), c::binary-size(1), tail::binary>> = phrase
    cond do
      (a<>b<>c == "thr") -> tail <> "thray"
      (a<>b<>c == "sch") -> tail <> "schay"
      (a<>b == "yt") -> phrase <> "ay"
      (a<>b == "xr") -> phrase <> "ay"
      (a<>b == "ch") -> c <> tail <> "chay"
      (a<>b == "qu") -> c <> tail <> "quay"
      (a<>b == "th") -> c <> tail <> "thay"
      (a =~ ~r/[aeiou]/ && b<>c == "qu") -> phrase <> "ay"
      (b<>c == "qu") -> tail <> a <> "quay"
      a =~ ~r/[aeiou]/ -> phrase <> "ay"
      true -> b <> c <> tail <> a <> "ay"
    end
  end
end

