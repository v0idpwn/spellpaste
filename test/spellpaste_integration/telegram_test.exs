defmodule SpellpasteIntegration.TelegramTest do
  use Spellpaste.DataCase

  alias SpellpasteIntegration.Telegram
  alias SpellpasteIntegration.Telegram.Message

  alias Tesla.Mock, as: TMock

  @base_bin_uri :spellpaste
                |> Application.get_env(:public_url)
                |> URI.merge("/b/")
                |> URI.to_string()

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
    test "default handler" do
      {:ok, message} = Telegram.build_message(%{chat_id: 1, message_id: 2, text: "bar"})

      assert {:ok, nil} = Telegram.process_message(message)
    end

    test "spellpaste handler" do
      TMock.mock(fn %{method: :post, body: body} ->
        assert %{
                 "chat_id" => _,
                 "reply_to_message_id" => _,
                 "text" => @base_bin_uri <> identifier
               } = Jason.decode!(body)

        assert {:ok, _bin} = Spellpaste.Pastes.get_bin_from_identifier(identifier)

        %Tesla.Env{}
      end)

      {:ok, message} =
        Telegram.build_message(%{
          chat_id: 1,
          from: %{username: "mambo"},
          message_id: 2,
          text: "/spellpaste",
          reply_to_message: %{message_id: 3, from: %{username: "jambo"}, text: "sample text"}
        })

      assert {:ok, _} = Telegram.process_message(message)
    end
  end

  describe "enqueue_processing!/1" do
    test "publishes event" do
      {:ok, message} = Telegram.build_message(%{chat_id: 1, message_id: 2, text: "bar"})
      assert :ok = Telegram.enqueue_processing!(message)
    end
  end
end
