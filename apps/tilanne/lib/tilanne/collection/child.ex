defmodule Tilanne.Collection.Child do
  use GenServer
  alias Tilanne.Collection.Image

  def start_link(path) do
    {:ok, pid} = GenServer.start_link(__MODULE__, path, id: path)
    Process.register(pid, String.to_atom(path))
    {:ok, pid}
  end

  def init(path) do
    i = instance(path)
    {:ok, i}
  end

  def handle_call(:tensorflow, _from, i) do
    reply = Tilanne.Python.call(i.python, :flow, :test, [])
    {:reply, reply, i}
  end

  def handle_call(:info, _from, i) do
    {:reply, i, i}
  end

  def handle_call(:overexposed?, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :overexposed, [i.path, self()])
    filter_reply(reply, i)
  end

  def handle_call(:blurry?, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :blurry, [i.path, self()])
    filter_reply(reply, i)
  end

  def handle_call(:people?, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :people, [i.path, self()])
    filter_reply(reply, i)
  end

  def handle_call({:face?, model}, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :face, [i.path, self(), model])
    filter_reply(reply, i)
  end

  def handle_call({:find?, model}, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :find, [i.path, self(), model])
    filter_reply(reply, i)
  end

  def handle_info(:overexposed!, i) do
    j = %{i | overexposed: :true}
    {:noreply, j}
  end

  def handle_info(:blurry!, i) do
    j = %{i | blurry: :true}
    {:noreply, j}
  end

  def handle_info(_msg, i) do
    {:noreply, i}
  end

  def child_spec(path) do
    %{
      id: String.to_atom(path),
      start: {__MODULE__, :start_link, [path]}
    }
  end

  defp instance(path) do
    %Image{
      name: Path.basename(path),
      path: path,
      python: Tilanne.Python.instance(:default)
    }
  end

  defp filter_reply(reply, i) do
    case reply do
      1 ->
        {:reply, i.path, i}
      0 ->
        {:reply, :nil, i}
    end 
  end
end
