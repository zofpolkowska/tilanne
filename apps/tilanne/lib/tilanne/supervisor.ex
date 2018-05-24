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

  def load(path) do
    Supervisor.start_child(:main, collection(path))
  end

  defp collection(path) do
    Supervisor.child_spec({Collection, path}, id: path)
  end
end
