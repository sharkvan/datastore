defmodule Webapi.StockView do
    use Webapi.Web, :view

    def render("stock.json", %{stock: stock}) do
        case stock do
            "" -> %{}
            _ -> stock
        end
    end
end
