defmodule OffsyncWeb.Live.AdminLive.Users do
  use OffsyncWeb, :live_view

  alias Offsync.Accounts

  @impl true
  def mount(_params, session, socket) do
    setup_status_indicator()
    
    users = Accounts.list_users()

    socket =
      socket
      |> assign_auth(session, type: :admin)
      |> assign(:page_title, "users")
      |> assign(:page, 0)
      |> assign(:users, users)

    {:ok, socket}
  end


  @impl true
  def render(assigns) do
    ~H"""
    <table class="table table-dark table-striped">
      <thead>
        <th scope="col">Adresse email</th>
        <th scope="col">Prénom</th>
        <th scope="col">Nom</th>
        <th scope="col">Type de membre</th>
      </thead>
      <tbody>
        <%= for user <- @users do %>
          <tr>
            <td><%= user.email %></td> 
            <td><%= user.first_name %></td> 
            <td><%= user.last_name %></td> 
            <td>
              <%= case user.type do %>
              <% :active -> %>
                Membre actif

              <% :standard -> %>
                Membre ordinaire

              <% :admin -> %>
                Admin

              <% end %>
            </td> 
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end
