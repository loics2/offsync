defmodule OffsyncWeb.PageController do
  use OffsyncWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
