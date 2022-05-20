defmodule Offsync.AccessLog do
  @moduledoc """
  The AccessLog context.
  """

  import Ecto.Query, warn: false

  alias Offsync.AccessLog.Entry
  alias Offsync.Repo

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries do
    Repo.all(Entry)
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  def get_latest_entry() do
    Entry
    |> first({:desc, :inserted_at})
    |> Repo.one()
    |> Repo.preload(:user)
  end

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    {:ok, value} =
      Repo.transaction(fn ->
        is_present =
          get_latest_entry()
          |> case do
            %Entry{is_present: p} ->
              p

            nil ->
              false
          end

        attrs =
          attrs
          |> Map.put(:is_present, !is_present)

        %Entry{}
        |> Entry.changeset(attrs)
        |> Repo.insert()
      end)

    value
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(%Entry{} = entry, attrs \\ %{}) do
    Entry.changeset(entry, attrs)
  end
end
