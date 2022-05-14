defmodule OffsyncWeb.Live.AdminLive.Users do
  use OffsyncWeb, :live_view

  alias Offsync.Accounts

  @impl true
  def mount(params, session, socket) do
    setup_status_indicator()
    page = Map.get(params, "page", 1)
    user_page = Accounts.list_users(page)

    socket =
      socket
      |> assign_auth(session, type: :admin)
      |> assign(:page_title, "users")
      |> assign(:page_number, user_page.page_number)
      |> assign(:total_pages, user_page.total_pages)
      |> assign(:users, user_page.entries)

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

    <nav aria-label="...">
      <ul class="pagination">
        <li class={"page-item #{if @page_number == 1, do: "disabled"}"}>
          <%= live_redirect("Previous",
            to: Routes.live_path(@socket, OffsyncWeb.Live.AdminLive.Users, page: @page_number - 1),
            class: "page-link",
            tabindex: -1
          ) %>
        </li>

        <%= for page <- 1..@total_pages do %>
          <li class={"page-item #{if @page_number == page, do: "active"}"}>
            <%= live_redirect(page,
              to: Routes.live_path(@socket, OffsyncWeb.Live.AdminLive.Users, page: page),
              class: "page-link"
            ) %>
          </li>
        <% end %>

        <li class={"page-item #{if @page_number == @total_pages, do: "disabled"}"}>
          <%= live_redirect("Next",
            to: Routes.live_path(@socket, OffsyncWeb.Live.AdminLive.Users, page: @page_number + 1),
            class: "page-link"
          ) %>
        </li>
      </ul>
    </nav>
    """
  end
end
