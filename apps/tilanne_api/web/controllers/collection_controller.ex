defmodule TilanneApi.CollectionController do
  use TilanneApi.Web, :controller

  def index(conn, _param) do
    collections = Tilanne.collections()
    render conn, "index.json", %{collections: collections}
  end

  def show(conn, %{"id" => id}) do
    images = Tilanne.images(String.to_atom(id))
    render conn, "show.json", %{id: id, images: images}
  end

  def create(conn, %{"path" => path, "id" => id}) do
    {:ok, _pid} = Tilanne.load(path, String.to_atom(id))
    render conn, "create.json", %{id: id, path: path}
  end

  def create(conn, %{"id" => "models"}) do
    {:ok, _pid} = Tilanne.models
    render conn, "create.json", %{id: "models", path: "models"}
  end

  def create(conn, _params) do
    {:ok, _pid} = Tilanne.load
    render conn, "create.json", %{id: "default", path: "default"}
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
    render conn, "selection.json", %{id: id, selection: selection, images: images}
  end

  def patterns(conn, %{"id" => id, "model" => model}) do
    i = String.to_atom(id)
    m = String.to_atom(model)

    images = Tilanne.find?(m, i)
    render conn, "selection.json", %{id: id, selection: model, images: images}
  end

end
