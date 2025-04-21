Code.require_file("caesar_cipher.exs", __DIR__)

ExUnit.start()
ExUnit.configure(trace: true)

defmodule CaesarCipherTest do
  use ExUnit.Case
  import CaesarCipher

  test "encode/decode" do
    assert encode(~c"Hello", 10) |> decode(10) == ~c"Hello"
    assert encode(~c"12345", 1) == ~c"23456"
    assert decode(~c"12345", 1) == ~c"01234"
    assert encode(~c"abcdef", 2) == ~c"cdefgh"
    assert decode(~c"abcdef", 2) == ~c"_`abcd"
    assert encode(~c"Hello", 10) == ~c"Rovvy"
    assert decode(~c"Rovvy", 10) == ~c"Hello"
  end
end
