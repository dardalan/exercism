defmodule CaesarCipher do
  def encode(text, shift) when is_list(text) do
    Enum.map(text, fn char -> char + shift end)
  end

  def decode(text, shift) when is_list(text) do
    Enum.map(text, fn char -> char - shift end)
  end
end
