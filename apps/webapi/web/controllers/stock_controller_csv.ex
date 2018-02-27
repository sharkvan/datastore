defmodule Webapi.StockControllerCSV do
    use Webapi.Web, :controller

    def csv(conn, %{}) do
        default = Webapi.StockCache.Cache.stream()
        |> Stream.take(1)
        |> Enum.at(0)
        |> Map.keys()
        |> List.foldl([], fn(key, acc) -> [{key, nil}] ++ acc end)
        |> Map.new()

        conn 
        |> put_resp_content_type("text/plain")
        |> send_resp(200, Webapi.StockCache.Cache.stream()
                                |> Stream.map(fn(m) -> Map.drop(m, ["dividends"]) end)
                                |> Stream.map(fn(m) -> Map.merge(default, m) end)
                                |> CSV.Encoding.Encoder.encode(headers: true)
                                |> Enum.to_list)
    end
end

