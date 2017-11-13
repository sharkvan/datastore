defmodule Webapi.StockFacetControllerTest do
  use Webapi.ConnCase

  #alias Webapi.StockFacet
  #@valid_attrs %{facet: "some content", value: "some content"}
  #@invalid_attrs %{}

  #setup %{conn: conn} do
  #  {:ok, conn: put_req_header(conn, "accept", "application/json")}
  #end

  #test "lists all entries on index", %{conn: conn} do
  #  conn = get conn, stock_facet_path(conn, :index)
  #  assert json_response(conn, 200)["data"] == []
  #end

  #test "shows chosen resource", %{conn: conn} do
  #  stock_facet = Repo.insert! %StockFacet{}
  #  conn = get conn, stock_facet_path(conn, :show, stock_facet)
  #  assert json_response(conn, 200)["data"] == %{"id" => stock_facet.id,
  #    "facet" => stock_facet.facet,
  #    "value" => stock_facet.value}
  #end

  #test "renders page not found when id is nonexistent", %{conn: conn} do
  #  assert_error_sent 404, fn ->
  #    get conn, stock_facet_path(conn, :show, -1)
  #  end
  #end

  #test "creates and renders resource when data is valid", %{conn: conn} do
  #  conn = post conn, stock_facet_path(conn, :create), stock_facet: @valid_attrs
  #  assert json_response(conn, 201)["data"]["id"]
  #  assert Repo.get_by(StockFacet, @valid_attrs)
  #end

  #test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #  conn = post conn, stock_facet_path(conn, :create), stock_facet: @invalid_attrs
  #  assert json_response(conn, 422)["errors"] != %{}
  #end

  #test "updates and renders chosen resource when data is valid", %{conn: conn} do
  #  stock_facet = Repo.insert! %StockFacet{}
  #  conn = put conn, stock_facet_path(conn, :update, stock_facet), stock_facet: @valid_attrs
  #  assert json_response(conn, 200)["data"]["id"]
  #  assert Repo.get_by(StockFacet, @valid_attrs)
  #end

  #test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #  stock_facet = Repo.insert! %StockFacet{}
  #  conn = put conn, stock_facet_path(conn, :update, stock_facet), stock_facet: @invalid_attrs
  #  assert json_response(conn, 422)["errors"] != %{}
  #end

  #test "deletes chosen resource", %{conn: conn} do
  #  stock_facet = Repo.insert! %StockFacet{}
  #  conn = delete conn, stock_facet_path(conn, :delete, stock_facet)
  #  assert response(conn, 204)
  #  refute Repo.get(StockFacet, stock_facet.id)
  #end
end
