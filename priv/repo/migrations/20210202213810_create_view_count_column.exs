defmodule Spellpaste.Repo.Migrations.CreateViewCountColumn do
  use Ecto.Migration

  def change do
    alter table(:bins) do
      add :view_count, :integer
    end
  end
end
