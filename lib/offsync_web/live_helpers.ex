defmodule OffsyncWeb.LiveHelpers do
  import Phoenix.LiveView

  alias OffsyncWeb.Router.Helpers, as: Routes
  alias Offsync.Accounts
  alias Offsync.Accounts.User

  def assign_auth(socket, session, opts \\ []) do
    optional? = opts[:optional] || false
    type = opts[:type]
    
    assign_new(socket, :current_user, fn -> find_current_user(session) end)
    |> enforce_login(optional?)
    |> check_type(type)

  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token) do
      user
    end
  end

  defp enforce_login(socket, optional?) do
    case {optional?, socket.assigns.current_user} do
      {_, %User{}} ->
        socket

      {true, _} ->
        socket

      {false, _} ->
        socket
        |> put_flash(:error, "You must log in to access this page.")
        |> redirect(to: Routes.user_session_path(socket, :new))
    end
  end

  defp check_type(socket, nil), do: socket
  defp check_type(socket, type) do
    user = socket.assigns.current_user
    if user do
      if user.type == type do
        socket
      else
        socket
        |> put_flash(:error, "You must be #{type} to access this page.")
        |> redirect(to: Routes.live_path(socket, OffsyncWeb.Live.IndexLive))
      end
    else
      socket
    end
  end
end

