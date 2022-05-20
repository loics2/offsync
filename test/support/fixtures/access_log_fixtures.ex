defmodule Offsync.AccessLogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Offsync.AccessLog` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        is_present: true
      })
      |> Offsync.AccessLog.create_entry()

    entry
  end
end
