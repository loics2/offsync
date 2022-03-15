defmodule OffsyncWeb.Live.IndexLive do
  use OffsyncWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _, socket) do
    setup_status_indicator()

    socket =
      socket
      |> assign(:page_title, "index.html")
    {:ok, socket}
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
      </div>
    """ 
  end
  
end
