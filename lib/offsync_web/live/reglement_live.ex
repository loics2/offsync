defmodule OffsyncWeb.Live.ReglementLive do
  use OffsyncWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    setup_status_indicator()
    
    socket =
      socket
      |> assign_auth(session, optional: true)
      |> assign(:page_title, "reglement.html")

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <h1 id="charte-offsync">Règlement offsync<span class="blinking-cursor">|</span></h1>
        <p class="lead">Ce document définit la charte de l’association et du local <strong>offsync</strong>.</p>
        <h2 id="valeurs">Valeurs</h2>
        <p>L’association poursuit les buts suivants :</p>
        <ul>
        <li>promouvoir une utilisation éthique, responsable et innovante des technologies</li>
        <li>promouvoir le partage des connaissances</li>
        <li>promouvoir la liberté d’utiliser, de créer et de modifier les outils techniques</li>
        <li>mettre à disposition et entretenir un lieu de création et de rencontre</li>
        </ul>
        <p>Tous les membres sont respectés et inclus indépendamment de leur genre, orientation sexuelle ou politique, religion… Le comité est à l’écoute en cas de litige et agira en conséquence.</p>
        <h2 id="adhésion">Adhésion</h2>
        <p>Toutes les personnes physiques ou morales qui s’engagent à la poursuite des buts de l’association peuvent devenir membre.</p>
        <p>Les cotisations sont les suivantes :</p>
        <ul>
        <li><strong>membre actif</strong> : 45.-/mois</li>
        <li><strong>membre ordinaire</strong> : 20.-/mois</li>
        </ul>
        <h2 id="local">Local</h2>
        <h3 id="accès">Accès</h3>
        <p>L’accès au local dépend du type de membre :</p>
        <ul>
        <li><strong>membre actif</strong> : accès illimité</li>
        <li><strong>membre ordinaire</strong> : accès seulement en présence d’un membre actif</li>
        </ul>
        <h3 id="ordre-et-propreté">Ordre et propreté</h3>
        <ul>
        <li>le matériel doit être rangé après son utilisation</li>
        <li>les places de travail doivent rester propres</li>
        <li>les déchets sont triés et mis dans la poubelle correspondante, les bouteilles consignées sont ramenées dans les caisses</li>
        <li>le local est non-fumeur</li>
        <li>merci de respecter nos voisins (niveaux sonores, etc)</li>
        <li>le membre actif qui ferme le local veille à éteindre les lumières et les appareils</li>
        </ul>
        <h2 id="matériel">Matériel</h2>
        <h3 id="informatique">Informatique</h3>
        <ul>
        <li>ne pas porter atteinte à la stabilité sur réseau</li>
        <li>ne pas exploiter de failles de sécurité hors d’un environnement de laboratoire</li>
        <li>en cas de détérioration du matériel, perte ou vol, prévenir au plus vite le propriétaire, un membre actif ou membre du comité</li>
        <li>toute utilisation du matériel ayant trait à des faits choquants et/ou relevant du droit pénal est interdit</li>
        <li>si un quelconque projet pourrait jouer sur un certain flou juridique, il est obligatoire d’en discuter avec un membre du comité afin d’en conclure si nous en prenons ou non la responsabilité.</li>
        </ul>
        <h3 id="achats">Achats</h3>
        <ul>
        <li>les demandes d’achats pour l’association sont à adresser au comité, qui demandera ensuite aux membres leur accord. Sans opposition des membres dans les 3 jours, la demande sera ensuite validée par le caissier.</li>
        <li>les demandes d’achats pour du matériel spécifique à un projet peuvent être adressées au comité pour la commande, mais les frais sont à la charge du ou des membres faisant la demande.</li>
        </ul>
        <h3 id="matériel-privé">Matériel privé</h3>
        <p>Chacun·e est responsable du matériel privé qu’il apporte.</p>
        <h2 id="divers">Divers</h2>
        <h3 id="responsabilité">Responsabilité</h3>
        <p>Chacun·e est responsable de sa sécurité et, dans le cadre d’expériences dangereuses, celle des autres membres présents.</p>
        <h3 id="activité-lucratives">Activité lucratives</h3>
        <p>Il est déconseillé d’utiliser les locaux ainsi que le matériel à des fins lucratives.</p>
      </div>
    """ 
  end
end
