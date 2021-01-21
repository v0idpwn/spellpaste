defmodule Spellpaste.Repo.Migrations.CreateBinTable do
  use Ecto.Migration

  def change do
    create table(:bins) do
      add :text, :text
      add :author, :string
      add :sender, :string
      add :programming_language, :string
      add :identifier, :string

      timestamps()
    end

    create unique_index(:bins, [:identifier])
  end
end
