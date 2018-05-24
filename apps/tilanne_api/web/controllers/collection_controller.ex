defmodule TilanneApi.CollectionController do
  use TilanneApi.Web, :controller

  def create(conn, %{"path" => path}) do
    {:ok, pid} = Tilanne.load(path)
    render conn, "create.json", %{path: path, p: Kernel.inspect(pid)}
  end
end
