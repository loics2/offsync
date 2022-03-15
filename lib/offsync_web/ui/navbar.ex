defmodule OffsyncWeb.UI.Navbar do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Offsync.StatusManager

  require Logger

  def on_mount(:default, _params, _session, socket) do
    {:cont,
     socket
     |> attach_hook(:active_page, :handle_params, &set_active_page/3)
     |> attach_hook(:is_space_open, :handle_params, &set_space_open/3)}
  end

  def navbar(assigns) do
    ~H"""
      <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
          <a class="navbar-brand" href="/">
            <%= if @is_open do %>
              <div class="dot dot-open" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Le hackerspace est ouvert"/>
            <% else %>
              <div class="dot dot-closed" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Le hackerspace est fermé"/>
            <% end %>
            offsync.html
          </a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
              <%= render_slot(@inner_block) %>
            </ul>
          </div>
        </div>
      </nav>
    """
  end
  
  def navbar_dropdown(assigns) do
   ~H"""
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
        data-bs-toggle="dropdown" aria-expanded="false"><%= @title %></a>
      <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark" style="background-color: #1d1e1c;" aria-labelledby="navbarDropdown">
        <%= render_slot(@inner_block) %>
      </ul>
    </li>
    """ 
  end

  def dropdown_link(%{active?: true} = assigns) do
     assigns =
      assigns
      |> assign_new(:to, fn -> "#" end)

    ~H"""
      <li>
        <%= live_redirect to: @to, class: "dropdown-item active" do%>
          <%= render_slot(@inner_block) %>
        <% end %>
      </li>
    """
  end
  
  def dropdown_link(%{active?: false} = assigns) do
     assigns =
      assigns
      |> assign_new(:to, fn -> "#" end)

    ~H"""
      <li>
        <%= live_redirect to: @to, class: "dropdown-item" do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </li>
    """
  end

  def navbar_link(%{active?: true} = assigns) do
     assigns =
      assigns
      |> assign_new(:to, fn -> "#" end)

    ~H"""
      <li class="nav-item">
        <%= live_redirect to: @to, class: "nav-link active" do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </li>
    """
  end
  
  def navbar_link(%{active?: false} = assigns) do
     assigns =
      assigns
      |> assign_new(:to, fn -> "#" end)

    ~H"""
      <li class="nav-item">
        <%= live_redirect to: @to, class: "nav-link" do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </li>
    """
  end

  defp set_active_page(_params, _url, socket) do
    active_page =
      case socket.view do
        OffsyncWeb.Live.IndexLive ->
          :index

        OffsyncWeb.Live.EtatLive ->
          :etat
        
        OffsyncWeb.Live.ReglementLive ->
          :reglement

        _ ->
          nil
      end

    {:cont, assign(socket, current_page: active_page)}
  end
  
  defp set_space_open(_params, _url, socket) do
    {:cont, assign(socket, is_open: StatusManager.open?())}
  end
end
