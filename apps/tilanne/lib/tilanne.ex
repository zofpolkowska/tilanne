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
    Tilanne.Supervisor.start_link()
  end

  defdelegate load, to: Tilanne.Supervisor, as: :load
  defdelegate images, to: Tilanne.Supervisor, as: :paths
  defdelegate overexposed?, to: Tilanne.Collection.Supervisor, as: :overexposed?
  defdelegate info, to: Tilanne.Collection.Supervisor, as: :info
  defdelegate blurry?, to: Tilanne.Collection.Supervisor, as: :blurry?
  defdelegate people?, to: Tilanne.Collection.Supervisor, as: :people?
  defdelegate face?(model), to: Tilanne.Collection.Supervisor, as: :face?
  defdelegate find?(model), to: Tilanne.Collection.Supervisor, as: :find?



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
