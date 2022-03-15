defmodule OffsyncWeb.Live.EtatLive do
  use OffsyncWeb, :live_view

  @impl true
  def mount(_params, _, socket) do
    setup_status_indicator()
    
    socket =
      socket
      |> assign(:page_title, "etat_du_projet.html")

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <h1>On en est où ?<span class="blinking-cursor">|</span></h1>
        <p class="lead">
            On est bientôt prêt à vous accueillir dans notre hackerspace, mais avant, il nous reste quelques trucs à
            faire :
            <ul>
                <li> Compléter le comité : nous ne sommes actuellement que deux derrière ce projet, et, bien que le tout
            sera géré horizontalement, il nous faudrait une ou deux personnes supplémentaires pour la gestion de
            l’association.</li>
                <li>Terminer les derniers détails administratifs et lancer officiellement l’association</li>
                <li>Récupérer des canapés, tables, chaises et autre mobilier, histoire qu’on se mette bien</li>
            </ul>
        </p>
        <p> Tu es motivé.e à t’impliquer dans ce projet en tant que membre du comité ? Si c’est le cas, envoie-nous un message et on se fera un plaisir de papoter avec toi.</p>

        <p>
            Si tu veux plutôt devenir membre de l’association (et donc profiter du local et du matériel), continue à nous suivre, on postera plus d’infos à ce sujet tout bientôt.
        </p>

        <p>
            Et dans tous les cas, tu peux nous donner un coup de main en parlant d’offsync à tout le monde!
        </p>
      </div>
    """ 
  end
end
