defmodule TilanneApi.Repo.Migrations.CreateCollection do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :id, :string
      add :path, :string

      timestamps()
    end
  end
end
