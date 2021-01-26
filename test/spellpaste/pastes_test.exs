defmodule Spellpaste.PastesTest do
  @moduledoc false

  use Spellpaste.DataCase

  alias Spellpaste.Pastes

  describe "create_bin/3" do
    test "creates a bin without author/sender" do
      assert {:ok, _bin} = Pastes.create_bin("hello")
    end

    test "creates a bin with both author/sender" do
      assert {:ok, _bin} = Pastes.create_bin("hello", "jonas", "jose")
    end
  end

  describe "last_bins/1" do
    test "Returns last few bins" do
      created =
        1..10
        |> Enum.map(&inspect/1)
        |> Enum.map(&Pastes.create_bin/1)
        |> Enum.map(fn {:ok, x} -> x end)

      assert Enum.take(Enum.reverse(created), 5) == Pastes.last_bins(5)
    end
  end

  describe "get_bin_from_identifier/1" do
    test "returns if exists" do
      {:ok, bin} = Pastes.create_bin("foo")
      assert {:ok, %Pastes.Bin{}} = Pastes.get_bin_from_identifier(bin.identifier)
    end

    test "returns error if doesnt exist" do
      assert {:error, :not_found} = Pastes.get_bin_from_identifier("foo")
    end
  end
end
