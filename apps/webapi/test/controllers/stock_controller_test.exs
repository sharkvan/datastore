defmodule Webapi.StockControllerTest do
    use Webapi.ConnCase

    test "return empty json because we have no data", %{conn: conn} do
        conn = get conn, stock_path(conn, :show, "iid")

        assert response(conn, 404) == ""
    end

    test "create new stock record", %{conn: conn} do
        post conn, stock_path(conn, :create), [stock: %{:symbol => "IID", :price => 3.56}]

        conn = get conn, stock_path(conn, :show, "IID")

        assert json_response(conn, 200) == %{"symbol" => "IID", "price" => 3.56}
    end

    test "Update stock record", %{conn: conn} do
        post conn, stock_path(conn, :create), [stock: %{:symbol => "IID", :price => 3.75}]
        conn = get conn, stock_path(conn, :show, "IID")
        assert json_response(conn, 200) == %{"symbol" => "IID", "price" => 3.75}

        put conn, stock_path(conn, :update, "IID"), [stock: %{:symbol => "IID", :price => 3.56}]
        conn = get conn, stock_path(conn, :show, "IID")
        assert json_response(conn, 200) == %{"symbol" => "IID", "price" => 3.56}
    end
end
