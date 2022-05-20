defmodule Offsync.AccessLog.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :is_present, :boolean

    belongs_to :user, Offsync.Accounts.User

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:is_present, :user_id])
    |> validate_required([:is_present, :user_id])
  end
end
