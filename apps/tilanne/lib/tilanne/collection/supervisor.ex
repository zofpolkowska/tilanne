defmodule Tilanne.Collection.Supervisor do
  use Supervisor
  alias Tilanne.Collection.Child, as: Child

  def start_link([path, id]) do
    p = String.to_atom(path)
    {:ok, pid} = Supervisor.start_link(__MODULE__, path)
    Process.register(pid, p)
    {:ok, pid}
  end

  def init(path) do
    children = Path.join(path,"/*")
    |> Path.wildcard
    |> Enum.map(&Child.child_spec/1)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def overexposed?(path) do
    call(path, :overexposed?)
    |> Enum.filter(&is_binary/1)
  end
  def blurry?(path) do
    call(path, :blurry?)
    |> Enum.filter(&is_binary/1)
  end

  def people?(path) do
    call(path, :people?)
    |> Enum.filter(&is_binary/1)
  end

  def face?(path, model) do
    call(path, {:face?, model})
    |> Enum.filter(&is_binary/1)
  end

  def find?(path, model) do
    call(path, {:find?, model})
    |> Enum.filter(&is_binary/1)
  end

  def info(path) do
    call(path, :info)
  end

  def call(path, request) do
    children(path)
    |> Enum.map(fn i -> GenServer.call(i, request) end)
  end

  def cast(path, request) do
    children(path)
    |> Enum.map(fn i -> GenServer.cast(i, request) end)
  end

  def children(path) do
    path
    #|> String.to_atom
    |> Supervisor.which_children
    |> Enum.map(fn e ->
      elem(e, 0) end)
  end


end

