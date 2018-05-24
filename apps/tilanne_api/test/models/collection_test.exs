defmodule TilanneApi.CollectionTest do
  use TilanneApi.ModelCase

  alias TilanneApi.Collection

  @valid_attrs %{id: "some id", path: "some path"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Collection.changeset(%Collection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Collection.changeset(%Collection{}, @invalid_attrs)
    refute changeset.valid?
  end
end
