defmodule TilanneApi.CollectionControllerTest do
  use TilanneApi.ConnCase

  alias TilanneApi.Collection
  @valid_attrs %{id: "some id", path: "some path"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, collection_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    collection = Repo.insert! %Collection{}
    conn = get conn, collection_path(conn, :show, collection)
    assert json_response(conn, 200)["data"] == %{"id" => collection.id,
      "id" => collection.id,
      "path" => collection.path}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, collection_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, collection_path(conn, :create), collection: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Collection, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, collection_path(conn, :create), collection: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    collection = Repo.insert! %Collection{}
    conn = put conn, collection_path(conn, :update, collection), collection: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Collection, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    collection = Repo.insert! %Collection{}
    conn = put conn, collection_path(conn, :update, collection), collection: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    collection = Repo.insert! %Collection{}
    conn = delete conn, collection_path(conn, :delete, collection)
    assert response(conn, 204)
    refute Repo.get(Collection, collection.id)
  end
end
