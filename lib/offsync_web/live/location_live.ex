defmodule OffsyncWeb.Live.LocationLive do
  use OffsyncWeb, :live_view

  alias Offsync.StatusManager

  @impl true
  def mount(_params, session, socket) do
    setup_status_indicator()

    socket =
      socket
      |> assign_auth(session, :optional_auth)
      |> assign(:page_title, "location.html")
      |> assign(:mapbox_token, Application.fetch_env!(:offsync, :mapbox_token))

    {:ok, socket}
  end

  @impl true
  def handle_event("toggle_open", _value, socket) do
    if StatusManager.open?() do
      StatusManager.close()
    else
      StatusManager.open()
    end

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <h1>Où sommes-nous ?<span class="blinking-cursor">|</span></h1>
      <p class="lead">
        Notre QG se situe au Marly Innovation Center.
      </p>
      <p>
        Le local est actuellement <%= if @is_open, do: "ouvert", else: "fermé" %>, il se trouve à l'adresse suivante :

        <address>
          offsync<br>
          Rte Ancienne Papeterie 241<br>
          1723 Marly
        </address>
      </p>
      <div id="map" phx-update="ignore" phx-hook="Mapbox" data-token={@mapbox_token}></div>
    """
  end

end
