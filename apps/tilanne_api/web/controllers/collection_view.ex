defmodule TilanneApi.CollectionView do
  use TilanneApi.Web, :view

  def render("create.json",  %{path: path, p: p}) do
    %{
      description: "creating collection ...",
      path: path,
      p: p
    }
  end

end
