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
      <h1>Bienvenue chez offsync !<span class="blinking-cursor">|</span></h1>
      <p class="lead">
        offsync est un hackerspace : un endroit dédié à la création et
        à l'expérimentation technologique, un endroit où partager ses
        connaissances et en apprendre de nouvelles. Et boire des binches
        de temps en temps.
      </p>
      <p>
        L'idée d'offsync est de mettre en relation des personnes
        s'intéressant de près ou de loin à la technologie et de
        réaliser ensemble les projets les plus fous, artistiques ou non,
        inutiles ou indispensables. Aucune connaissance spécifique n'est
        requise, on a tous·te quelque chose à apporter. Qui que tu sois,
        quoi que tu fasses, tu es le·la bienvenu·e!
      </p>
      <p>
        Pour avoir accès au local et au matériel d'offsync, il te suffit de
        <%= live_redirect("devenir membre", to: Routes.user_registration_path(@socket, :new)) %>
        et de payer une cotisation mensuelle. Nous organisons toutefois
        des évènements ouverts au public, suis-nous sur les réseaux
        pour rester au courant. Garde aussi un oeil sur la pastille à côté
        du logo ci-dessus : si elle est verte, quelqu'un se trouve au local
        et tu peux y venir!
      </p>

      <h2>TODOs</h2>
      <p>
        L'association et le local sont des projets récents, et il nous
        manque encore quelques trucs:

        <ul>
          <li>Connexion Internet</li>
          <li>Bureaux et chaises</li>
          <li>Matériel électronique (fer à souder, etc.)</li>
          <li>Outils divers (tourne-vis, pinces, etc.)</li>
        </ul>

        Si tu as des bons plans ou du matériel à nous donner, n'hésite pas à nous contacter!
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
