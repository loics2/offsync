defmodule Offsync.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  @enum_type_name :member_type

  def change do
    execute(
      "CREATE TYPE #{@enum_type_name} AS ENUM ('active', 'standard', 'admin')",
      "DROP TYPE #{@enum_type_name}"
    )

    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :email, :citext, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      add :type, @enum_type_name
      timestamps()
    end

    create unique_index(:users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
