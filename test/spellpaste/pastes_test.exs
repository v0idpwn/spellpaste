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
end
