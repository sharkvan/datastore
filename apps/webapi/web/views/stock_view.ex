defmodule Webapi.StockView do
    use Webapi.Web, :view

    def render("stock.json", %{stock: stock}) do
        case stock do
            "" -> %{}
            _ -> stock
        end
    end

    def render("stock.csv", %{stocks: stocks}) do
        stocks
        |> CSV.Encoding.Encoder.encode(headers: true)
    end

    def render("stock.csv", %{stock: stock}) do
        [stock]
        |> CSV.Encoding.Encoder.encode(headers: true)
    end
end
