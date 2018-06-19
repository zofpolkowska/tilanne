defmodule Tilanne.Supervisor do
  use Supervisor
  alias Tilanne.Collection.Supervisor, as: Collection

  def start_link() do
    {:ok, pid} = Supervisor.start_link(__MODULE__, [])
    Process.register(pid, :main)
    {:ok, pid}
  end

  def init([]) do
    Supervisor.init([], strategy: :one_for_one)
  end

  def load do
    path = Application.get_env(:Tilanne, :data)
    case Supervisor.start_child(:main, collection(path, :default)) do
      {:ok, _} -> "success"
      {:error, reason} -> case reason do
                            {r, _} -> Atom.to_string(r)
                            _ -> "failed to start the process"
                          end
    end
  end

  def update(name, id \\ :default) do
    case id do
             :default ->
               dir = Application.get_env(:Tilanne, :data)
               path = Path.join(dir, name)
               case Supervisor.start_child(id, Tilanne.Collection.Child.child_spec(path)) do
                 {:ok, pid} -> {"success", path}
                 _ -> {"failed to load", path}
               end
             :models ->
               dir = Application.get_env(:Tilanne, :models)
               path = Path.join(dir, name)
               case Supervisor.start_child(id, Tilanne.Collection.Child.child_spec(path)) do
                 {:ok, pid} -> {"success", path}
                 _ -> {"failed to load", path}
               end
             _ ->
               {"failed to load", "path not determined"}
    end
  end

  def models do
    path = Application.get_env(:Tilanne, :models)
    case Supervisor.start_child(:main, collection(path, :models)) do
      {:ok, _} -> "success"
      {:error, reason} -> case reason do
                            {r, _} -> Atom.to_string(r)
                            _ -> "failed to start the process"
                          end
    end
  end

  def load(path, id) do
    case Supervisor.start_child(:main, collection(path, id)) do
      {:ok, _} -> "success"
      {:error, reason} -> case reason do
                            {r, _} -> Atom.to_string(r)
                            _ -> "failed to start the process"
                          end
    end
  end

  defp collection(path, id) do
    Supervisor.child_spec({Collection, [path, id]}, id: id)
  end

  def paths() do
    Supervisor.which_children(:main)
    |> Enum.map(fn({path,_,_,_}) -> path end)
  end
end
