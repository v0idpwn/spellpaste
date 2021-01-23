defmodule SpellpasteIntegration.Telegram.ClientInputs.SendMessage do
  @moduledoc false

  use SpellpasteIntegration.Telegram.ClientInputs
  use Ecto.Schema

  alias Ecto.Changeset

  embedded_schema do
    field :chat_id, :integer
    field :text, :string
    field :parse_mode, :string
    field :caption_entities, {:array, :map}
    field :disable_web_page_preview, :boolean
    field :disable_notification, :boolean
    field :reply_to_message_id, :integer
    field :allow_sending_without_reply, :boolean
    field :reply_markup, :map
  end

  #@impl true
  def cast(params) do
    %__MODULE__{}
    |> Changeset.cast(params, __schema__(:fields))
    |> Changeset.validate_required([:chat_id, :text])
  end
end
