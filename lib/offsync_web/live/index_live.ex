defmodule OffsyncWeb.Live.IndexLive do
  use OffsyncWeb, :live_view

  require Logger

  @impl true
  def mount(_params, session, socket) do
    setup_status_indicator()

    socket =
      socket
      |> assign_auth(session, optional: true)
      |> assign(:page_title, "index.html")
    {:ok, socket}
  end

  @impl true
  def handle_event("toggle_open", _value, socket) do
    if Offsync.StatusManager.open?() do
      Offsync.StatusManager.close()
    else
      Offsync.StatusManager.open()
    end

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <h1>Un hackerspace, c'est quoi ?<span class="blinking-cursor">|</span></h1>
        <p class="lead">
            C'est un lieu d'expérimentation et de rencontre où des gens ayant un intérêt commun se retrouvent pour
            collaborer. Les membres y travaillent sur leurs projets en toute liberté, en partageant leurs
            connaissances avec la communauté. Dans ce cas, le hacking est l'art de modifier ou bricoler un objet ou
            un programme.
        </p>
        <p> Dans le cas d'offsync, c'est un atelier centré sur
            l'informatique et l'électronique. Nous fournirons
            un atelier équipé du nécessaire pour y créer les
            projets les plus fous, artistiques ou non, inutiles ou indispensables.</p>

        <p>
            Qui que tu sois, quoi que tu fasses, tu es le·la
            bienvenu·e!
        </p>

        <%= if @current_user do %>
          <%= unless @current_user.type == :standard do %>
            <%= if @is_open do %>
              <button phx-click="toggle_open">J'y suis plus.</button>
            <% else %>
              <button phx-click="toggle_open">J'y suis!</button>
            <% end %>
          <% end %>
        <% end %>
      </div>
    """ 
  end
  
end
