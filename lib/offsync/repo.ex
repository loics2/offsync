defmodule Offsync.Repo do
  use Ecto.Repo,
    otp_app: :offsync,
    adapter: Ecto.Adapters.Postgres
end
