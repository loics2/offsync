defmodule Offsync.AccessLogTest do
  use Offsync.DataCase

  import Offsync.AccountsFixtures

  alias Offsync.AccessLog

  setup do
    user = user_fixture()

    {:ok, user: user}
  end

  describe "entries" do
    alias Offsync.AccessLog.Entry

    import Offsync.AccessLogFixtures

    @invalid_attrs %{}

    test "list_entries/0 returns all entries", %{user: user} do
      entry = entry_fixture(%{user_id: user.id})
      assert AccessLog.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id", %{user: user} do
      entry = entry_fixture(%{user_id: user.id})
      assert AccessLog.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry", %{user: user} do
      valid_attrs = %{
        user_id: user.id,
        is_present: false
      }

      assert {:ok, %Entry{} = entry} = AccessLog.create_entry(valid_attrs)
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccessLog.create_entry(@invalid_attrs)
    end

    test "get_latest_entry/0 returns the latest entry", %{user: user} do
      _ = entry_fixture(%{user_id: user.id})
      latest = entry_fixture(%{user_id: user.id, is_present: false})

      assert {:ok, latest} = AccessLog.get_latest_entry()
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = AccessLog.change_entry(entry)
    end
  end
end
