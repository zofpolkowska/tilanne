defmodule TilanneApi.CollectionView do
  use TilanneApi.Web, :view

  def render("index.json", %{collections: collections}) do
    %{
      collections: collections
    }
  end

  def render("show.json",%{id: id, images: images}) do
    %{
      collection: id,
      images: images
    }
  end

  def render("create.json",  %{id: id, path: path, result: result}) do
    %{
      description: result,
      id: id,
      path: path
    }
  end

  def render("selection.json", %{id: id, selection: selection, images: images}) do
    %{
      from: id,
      selection: selection,
      results: images
    }
  end
end
