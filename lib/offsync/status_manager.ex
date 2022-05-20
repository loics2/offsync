defmodule Offsync.StatusManager do
  alias Offsync.AccessLog
  alias Offsync.AccessLog.Entry
  alias Offsync.Accounts.User

  def toggle(%User{id: user_id} = user) do
    {:ok, %Entry{is_present: is_present}} = AccessLog.create_entry(%{user_id: user_id})

    Phoenix.PubSub.broadcast(
      Offsync.PubSub,
      "status",
      {:status_update, %{is_present: is_present, user: user}}
    )
  end

  def open?() do
    AccessLog.get_latest_entry()
    |> case do
      %Entry{is_present: is_present, user: user} ->
        {is_present, user}

      nil ->
        {false, nil}
    end
  end
end
