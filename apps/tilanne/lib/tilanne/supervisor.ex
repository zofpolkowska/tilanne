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

  def load(path \\ "../../data", id \\ :default) do
    Supervisor.start_child(:main, collection(path, id))
  end

  defp collection(path, id) do
    Supervisor.child_spec({Collection, [path, id]}, id: id)
  end

  def paths() do
    Supervisor.which_children(:main)
    |> Enum.map(fn({path,_,_,_}) -> path end)
  end
end
