defmodule OffsyncWeb.LiveHelpers do
  import Phoenix.LiveView

  alias OffsyncWeb.Router.Helpers, as: Routes
  alias Offsync.Accounts
  alias Offsync.Accounts.User

  def assign_auth(socket, session, :optional_auth) do
    # OffsyncWeb.Endpoint.subscribe(UserAuth.pubsub_topic())

    assign_new(socket, :current_user, fn -> find_current_user(session) end)
  end

  def assign_auth(socket, session) do
    socket = assign_auth(socket, session, :optional_auth)

    case socket.assigns.current_user do
      %User{} ->
        socket

      _ ->
        socket
        |> put_flash(:error, "You must log in to access this page.")
        |> redirect(to: Routes.user_session_path(socket, :new))
    end
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token) do
      user
    end
  end
end

