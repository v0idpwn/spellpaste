defmodule SpellpasteIntegration.TelegramTest do
  use Spellpaste.DataCase

  alias SpellpasteIntegration.Telegram
  alias SpellpasteIntegration.Telegram.Message

  describe "build_message/1" do
    test "returns message if valid" do
      params = %{chat_id: 1, message_id: 2, text: "bar"}

      assert {:ok, %Message{}} = Telegram.build_message(params)
    end

    test "returns error if invalid" do
      params = %{chat_id: 1}

      assert {:error, %Ecto.Changeset{}} = Telegram.build_message(params)
    end
  end

  describe "process_message/1" do
    test "handles message" do
      {:ok, message} = Telegram.build_message(%{chat_id: 1, message_id: 2, text: "bar"})

      assert {:ok, nil} = Telegram.process_message(message)
    end
  end
end
