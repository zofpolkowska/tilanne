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

  def selection(conn, %{"id" => id, "selection" => selection}) do
    _id = String.to_atom(id)
    _selection = String.to_atom(selection)
    case _selection do
      :overexposed ->
        images = Tilanne.overexposed?(_id)
      :blurry ->
        images = Tilanne.blurry?(_id)
      :people ->
        images = Tilanne.people?(_id)
    end
    render conn, "selection.json", %{id: id, selection: selection, images: images}
  end

end
