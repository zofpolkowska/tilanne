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

  def load(path, id) do
    p = String.to_atom(path)
    cond do
      Enum.member?(paths(), p) == false ->
        Supervisor.start_child(:main, collection(path, id))
      true ->
        :exists
    end
  end

  defp collection(path, id) do
    p = String.to_atom(path)
    Supervisor.child_spec({Collection, [path, id]}, id: p)
  end

  def paths() do
    Supervisor.which_children(:main)
    |> Enum.map(fn({path,_,_,_}) -> path end)
  end

  def delete(path) do
    Supervisor.delete_child(__MODULE__, path)
  end
end
