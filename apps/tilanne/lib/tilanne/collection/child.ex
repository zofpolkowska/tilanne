defmodule Tilanne.Collection.Child do
  use GenServer
  alias Tilanne.Collection.Image

  def start_link(path) do
    name = Path.basename(path)
    {:ok, pid} = GenServer.start_link(__MODULE__, path, id: name)
    Process.register(pid, String.to_atom(name))
    {:ok, pid}
  end

  def init(path) do
    i = instance(path)
    {:ok, i}
  end

  def handle_call(:path, _from, i) do
    {:reply, i.path, i}
  end

  def handle_call(:tensorflow, _from, i) do
    reply = Tilanne.Python.call(i.python, :flow, :test, [])
    {:reply, reply, i}
  end

  def handle_call(:info, _from, i) do
    {:reply, i, i}
  end

  def handle_call(:overexposed?, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :overexposed, [i.path, self(), i.sol])
    filter_reply(reply, i)
  end

  def handle_call(:blurry?, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :blurry, [i.path, self(), i.sol])
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
    reply = Tilanne.Python.call(i.python, :lib, :find, [i.path, i.sol, model])
    filter_reply(reply, i)
  end

  def handle_call(:test, _from, i) do
    reply = Tilanne.Python.call(i.python, :lib, :test, [])
    {:reply, reply, i}
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
      id: String.to_atom(Path.basename(path)),
      start: {__MODULE__, :start_link, [path]}
    }
  end

  defp instance(path) do
    %Image{
      name: Path.basename(path),
      path: path,
      python: Tilanne.Python.instance(:default),
      dir: Path.dirname(path),
      sol: Path.join(Application.get_env(:Tilanne, :solution),
        Path.basename(path))
    }
  end

  defp filter_reply(reply, i) do
    case reply do
      1 ->
        {:reply, i.name, i}
      0 ->
        {:reply, :nil, i}
    end 
  end
end
