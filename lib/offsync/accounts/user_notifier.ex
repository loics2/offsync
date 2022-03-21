defmodule Offsync.Accounts.UserNotifier do
  import Swoosh.Email

  alias Offsync.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"offsync", "info@offsync.ch"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(user.email, "Confirme ton inscription", """

    ==============================

    Salut #{user.first_name},

    Merci pour ton inscription à offsync! Il ne te reste plus
    qu'à confirmer ton compte en visitant l'adresse suivante :

    #{url}

    Tu peux aussi verser le montant de ta cotisation sur notre
    compte (en précisant ton nom dans le champ de communication) :

    CH57 0076 8300 1642 2750 6
    
    A la prochaine!

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, "Mot de passe oublié", """

    ==============================

    Salut #{user.first_name},

    Tu peux remettre à zéro le mot de passe de ton compte offsync
    à l'adresse suivante :

    #{url}

    A la prochaine!

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Changement d'adresse email", """

    ==============================

    Salut #{user.first_name},

    Tu peux changer l'adresse email de ton compte offsync
    à l'adresse suivante :

    #{url}

    A la prochaine!

    ==============================
    """)
  end
end
