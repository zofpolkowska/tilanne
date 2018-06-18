defmodule Tilanne.Collection.Supervisor do
  use Supervisor
  alias Tilanne.Collection.Child, as: Child

  def start_link([path, id]) do
    #p = String.to_atom(path)
    {:ok, pid} = Supervisor.start_link(__MODULE__, path)
    Process.register(pid, id)
    {:ok, pid}
  end

  def init(path) do
    children = Path.join(path,"/*.{jpg,jpeg,png}")
    |> Path.wildcard
    |> Enum.map(&Child.child_spec/1)

    Supervisor.init(children, strategy: :one_for_one)
  end

#  def update do
#  end

  def overexposed?(id \\ :default) do
    call(id, :overexposed?)
    |> Enum.filter(&is_binary/1)
  end
  def blurry?(id \\ :default) do
    call(id, :blurry?)
    |> Enum.filter(&is_binary/1)
  end

  def people?(id \\ :default) do
    call(id, :people?)
    |> Enum.filter(&is_binary/1)
  end

  def face?(model, id \\ :default) do
    call(id, {:face?, model})
    |> Enum.filter(&is_binary/1)
  end

  def find?(model_name, id \\ :default) do
    model = GenServer.call(model_name, :path)
    call(id, {:find?, model})
    |> Enum.filter(&is_binary/1)
  end

  def info(id \\ :default) do
    call(id, :info)
  end

  def call(id, request) do
    children(id)
    |> Enum.map(fn i -> GenServer.call(i, request) end)
  end

  def cast(id, request) do
    children(id)
    |> Enum.map(fn i -> GenServer.cast(i, request) end)
  end

  def children(id \\ :default) do
    id
    #|> String.to_atom
    |> Supervisor.which_children
    |> Enum.map(fn e ->
      elem(e, 0) end)
  end

  def cleanup do
    path = Application.get_env(:Tilanne, :solution)
    children = Path.join(path,"/*.{jpg,jpeg,png}")
    |> Path.wildcard
    |> Enum.map(&File.rm/1)
  end

  def solution do
    path = Application.get_env(:Tilanne, :solution)
    children = Path.join(path,"/*.{jpg,jpeg,png}")
    |> Path.wildcard
    |> Enum.map(&Path.basename/1)
  end


end
