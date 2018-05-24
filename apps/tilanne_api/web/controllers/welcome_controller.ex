defmodule TilanneApi.WelcomeController do
  use TilanneApi.Web, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end

