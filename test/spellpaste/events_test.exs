defmodule Spellpaste.EventsTest do
  alias Spellpaste.Events

  use Spellpaste.DataCase

  describe "publish!/2" do
    test "raises if receives invalid topic" do
      assert_raise FunctionClauseError, fn ->
        Events.publish!(MyRandomEvent, %{})
      end
    end

    test "raises if payload is invalid" do
      assert_raise ArgumentError, fn ->
        Events.publish!(Events.TelegramMessage, %{})
      end
    end

    test "broadcasts if given proper input" do
      :ok = Events.publish!(Events.TelegramMessage, %{text: "k", message_id: 1})
    end
  end
end
