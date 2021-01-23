defmodule SpellpasteIntegration.Telegram.ClientTest do
  use Spellpaste.DataCase

  import Tesla.Mock

  alias SpellpasteIntegration.Telegram.Client

  describe "send_message/1" do
    test "fails if required fields arent given" do
      assert {:error, _changeset} = Client.send_message(%{})
    end

    test "makes a request if params are valid" do
      params = %{chat_id: 1, text: "foobar"}

      mock(fn %{method: :post, body: body} ->
        assert %{"chat_id" => _, "text" => _} = Jason.decode!(body)
        %Tesla.Env{}
      end)

      assert {:ok, _resp} = Client.send_message(params)
    end
  end
end
