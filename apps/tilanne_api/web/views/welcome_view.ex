defmodule TilanneApi.WelcomeView do
  use TilanneApi.Web, :view

  def render("index.json", _assigns) do
    %{
      description: "API for Tilanne",
      authors: "Zofia Polkowska & Jan Gapski"
    }
  end

end

