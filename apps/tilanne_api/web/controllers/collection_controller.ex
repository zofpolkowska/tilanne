defmodule TilanneApi.CollectionController do
  use TilanneApi.Web, :controller

  def index(conn, _param) do
    collections = Tilanne.collections()
    count = Enum.count(collections)
    render conn, "index.json", %{collections: count}
  end

  def show(conn, %{"id" => id}) do
    images = Tilanne.images(String.to_atom(id))
    render conn, "show.json", %{id: id, images: images}
  end

  def create(conn, %{"path" => path, "id" => id}) do
    result = Tilanne.load(path, String.to_atom(id))
    render conn, "create.json", %{id: id, path: path, result: result}
  end

  def create(conn, %{"id" => "models"}) do
    result = Tilanne.models
    render conn, "create.json", %{id: "models", path: "models", result: result}
  end

  def create(conn, _params) do
    result = Tilanne.load
    render conn, "create.json", %{id: "default", path: "default", result: result}
  end

  def selection(conn, %{"id" => id, "selection" => selection}) do
    a = String.to_atom(id)
    s = String.to_atom(selection)
    images = case s do
      :overexposed ->
        Tilanne.overexposed?(a)
      :blurry ->
        Tilanne.blurry?(a)
      :people ->
        Tilanne.people?(a)
             end
    count = Enum.count(images)
    render conn, "selection.json", %{id: id, selection: selection, images: count}
  end

  def patterns(conn, %{"id" => id, "model" => model}) do
    i = String.to_atom(id)
    m = String.to_atom(model)

    images = Tilanne.find?(m, i)
    render conn, "selection.json", %{id: id, selection: model, images: images}
  end

end
