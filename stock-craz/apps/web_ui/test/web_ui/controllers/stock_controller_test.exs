defmodule WebUi.StockControllerTest do
  use WebUi.ConnCase

  alias StockCraz.Securities

  @create_attrs %{eps: "120.5", name: "some name", price: "120.5", price_high_year: "120.5", price_low_year: "120.5", symbol: "XYZ"}
  @update_attrs %{eps: "456.7", name: "some updated name", price: "456.7", price_high_year: "456.7", price_low_year: "456.7", symbol: "UVW"}
  @invalid_attrs %{eps: nil, name: nil, price: nil, price_high_year: nil, price_low_year: nil, symbol: nil}

  def fixture(:stock) do
    {:ok, stock} = Securities.create_stock(@create_attrs)
    stock
  end

  describe "index" do
    test "lists all stocks", %{conn: conn} do
      conn = get conn, stock_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Stocks"
    end
  end

  describe "new stock" do
    test "renders form", %{conn: conn} do
      conn = get conn, stock_path(conn, :new)
      assert html_response(conn, 200) =~ "New Stock"
    end
  end

  describe "create stock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, stock_path(conn, :create), stock: @create_attrs

      assert %{symbol: symbol} = redirected_params(conn)
      assert redirected_to(conn) == stock_path(conn, :show, symbol)

      conn = get conn, stock_path(conn, :show, symbol)
      assert html_response(conn, 200) =~ "Show Stock"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, stock_path(conn, :create), stock: @invalid_attrs
      assert html_response(conn, 200) =~ "New Stock"
    end
  end

  describe "edit stock" do
    setup [:create_stock]

    test "renders form for editing chosen stock", %{conn: conn, stock: stock} do
      conn = get conn, stock_path(conn, :edit, stock)
      assert html_response(conn, 200) =~ "Edit Stock"
    end
  end

  describe "update stock" do
    setup [:create_stock]

    test "redirects when data is valid", %{conn: conn, stock: stock} do
      conn = put conn, stock_path(conn, :update, stock), stock: @update_attrs
      assert redirected_to(conn) == "/stocks/UVW"

      conn = get conn, stock_path(conn, :show, "UVW")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, stock: stock} do
      conn = put conn, stock_path(conn, :update, stock), stock: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Stock"
    end
  end

  describe "delete stock" do
    setup [:create_stock]

    test "deletes chosen stock", %{conn: conn, stock: stock} do
      conn = delete conn, stock_path(conn, :delete, stock)
      assert redirected_to(conn) == stock_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, stock_path(conn, :show, stock)
      end
    end
  end

  defp create_stock(_) do
    stock = fixture(:stock)
    {:ok, stock: stock}
  end
end
