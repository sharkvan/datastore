defmodule Webapi.StockControllerCSV do
    use Webapi.Web, :controller

    def csv(conn, %{}) do
        conn 
        |> put_resp_content_type("text/plain")
        |> send_resp(200, Webapi.StockCache.Cache.stream()
                                |> CSV.Encoding.Encoder.encode(headers: true)
                                |> Enum.to_list)
    end
end
