defmodule Webapi.StockController do
    use Webapi.Web, :controller

    def show(conn, %{"symbol" => ticker}) do
        stock = Webapi.StockCache.Cache.fetch(ticker, fn -> "" end)
        case stock do
            "" -> send_resp(conn, :not_found, "")
            %{} -> render conn, "stock.json", stock: stock
        end
    end

    def create(conn, %{"stock" => stock}) do
        IO.inspect stock
        
        stock = case is_map(stock) do
            false -> Poison.decode!(stock)
            true -> stock
        end
        
        symbol = Map.get(stock, "symbol")
        Webapi.StockCache.Cache.set symbol, stock

        conn
        |> put_status(:created)
        |> put_resp_header("location", stock_path(conn, :show, symbol))
        |> render("stock.json", stock: stock)
    end

    def update(conn, %{"stock" => stock}) do
        IO.inspect stock

        stock = case is_map(stock) do
            false -> Poison.decode!(stock)
            true -> stock
        end
        
        symbol = Map.get(stock, "symbol")
        Webapi.StockCache.Cache.set symbol, stock

        conn
        |> send_resp(:no_content, "")
    end
end

