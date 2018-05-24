defmodule Tilanne.Python do

  def instance(path) when is_list(path) do
    {:ok, pid} = :python.start([{:python_path, to_charlist(path)}])
    pid
  end

  def instance(_) do
    {:ok, pid} = :python.start([{:python_path, default_instance()}])
    pid
  end

  defp default_instance() do
    [:code.priv_dir(:tilanne), "python"] 
    |> Path.join()
    |> to_charlist
  end

  def call(pid, m, f, args \\ []) do
    pid
    |>:python.call(m, f, args)
  end

  def cast(pid, msg) do 
    :python.cast(pid, msg)
  end
  
  def stop(pid) do 
    :python.stop(pid)
  end

end
