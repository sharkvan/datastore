defmodule Webapi.StockControllerCSV do
    use Webapi.Web, :controller

    def csv(conn, %{}) do
        default = Webapi.StockCache.Cache.stream()
        |> Stream.take(1)
        |> Enum.at(0)
        |> Map.keys()
        |> List.foldl([], fn
            key, acc when key == "dividends" -> acc
            key, acc -> [{key, nil}] ++ acc 
           end)
        |> Map.new()

        conn 
        |> put_resp_content_type("text/plain")
        |> send_resp(200, Webapi.StockCache.Cache.stream()
                                |> Stream.map(fn(m) -> 
                                    div = latest_div(Map.get(m, "dividends", {}))
                                    m = Map.drop(m, ["dividends"])
                                    Map.merge(m, div)
                                    end)
                                |> Stream.map(fn(m) -> Map.merge(default, m) end)
                                |> CSV.Encoding.Encoder.encode(headers: true)
                                |> Enum.to_list)
    end

    defp latest_div(map) when map_size(map) == 0, do: map

    defp latest_div(map) do
        map
        |> Map.to_list()
        |> List.foldl({}, &max_paydate/2)
        |> case do
            {_, div} -> div
        end
    end

    defp max_paydate(left, right) when tuple_size(right) == 0, do: left

    defp max_paydate(left, right) do
        IO.inspect left
        IO.inspect right
        {_, %{"payDate" => left_date}} = left
        {_, %{"payDate" => right_date}} = right

        case Date.compare(Date.from_iso8601!(left_date), Date.from_iso8601!(right_date)) do
            :lt -> right
            :gt -> left
            :eq -> right
        end
    end
end

