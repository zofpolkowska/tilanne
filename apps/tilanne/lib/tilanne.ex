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

  defdelegate load(path), to: Tilanne.Supervisor, as: :load
  defdelegate overexposed?(path), to: Tilanne.Collection.Supervisor, as: :overexposed?
  defdelegate info(path), to: Tilanne.Collection.Supervisor, as: :info
  defdelegate blurry?(path), to: Tilanne.Collection.Supervisor, as: :blurry?
  defdelegate people?(path), to: Tilanne.Collection.Supervisor, as: :people?
  defdelegate face?(path, model), to: Tilanne.Collection.Supervisor, as: :face?
  defdelegate find?(path, model), to: Tilanne.Collection.Supervisor, as: :find?
end
