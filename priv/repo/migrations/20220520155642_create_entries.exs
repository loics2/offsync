defmodule Offsync.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :user_id, references(:users), null: false
      add :is_present, :boolean

      timestamps(updated_at: false)
    end
  end
end
