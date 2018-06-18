defmodule Tilanne do
  use Application
  @moduledoc """
  Documentation for Tilanne.
  """

  @doc """
  Tilanne application.

  ## Examples

      iex> ...

  """
  def start(_type, _args) do
    base = File.cwd!
    Application.put_env(:Tilanne, :project, Path.expand("../..", base))
    Application.put_env(:Tilanne, :data, Path.expand("../../data", base))
    Application.put_env(:Tilanne, :models, Path.expand("../../models", base))
    Application.put_env(:Tilanne, :solution, Path.expand("../../solution", base))

    Tilanne.Supervisor.start_link()
  end

  defdelegate load, to: Tilanne.Supervisor, as: :load
  defdelegate models, to: Tilanne.Supervisor, as: :models
  defdelegate images, to: Tilanne.Collection.Supervisor, as: :children
  defdelegate overexposed?, to: Tilanne.Collection.Supervisor, as: :overexposed?
  defdelegate info, to: Tilanne.Collection.Supervisor, as: :info
  defdelegate blurry?, to: Tilanne.Collection.Supervisor, as: :blurry?
  defdelegate people?, to: Tilanne.Collection.Supervisor, as: :people?
  defdelegate face?(model), to: Tilanne.Collection.Supervisor, as: :face?
  defdelegate find?(model), to: Tilanne.Collection.Supervisor, as: :find?
  defdelegate solution, to: Tilanne.Collection.Supervisor, as: :solution
  defdelegate cleanup, to: Tilanne.Collection.Supervisor, as: :cleanup



  defdelegate collections(), to: Tilanne.Supervisor, as: :paths
  defdelegate images(path), to: Tilanne.Collection.Supervisor, as: :children
  defdelegate load(path, id), to: Tilanne.Supervisor, as: :load
  defdelegate overexposed?(path), to: Tilanne.Collection.Supervisor, as: :overexposed?
  defdelegate info(path), to: Tilanne.Collection.Supervisor, as: :info
  defdelegate blurry?(path), to: Tilanne.Collection.Supervisor, as: :blurry?
  defdelegate people?(path), to: Tilanne.Collection.Supervisor, as: :people?
  defdelegate face?(model, path), to: Tilanne.Collection.Supervisor, as: :face?
  defdelegate find?(model, path), to: Tilanne.Collection.Supervisor, as: :find?
end
