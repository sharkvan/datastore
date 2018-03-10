defmodule Webapi.StockControllerCSV do
    use Webapi.Web, :controller

    def csv(conn, %{}) do
        default = %{ "amount" => 0.0,
                     "change" => 0.0,
                     "eps" => 0.0,
                     "exDate" => " ",
                     "payDate" => " ",
                     "qtrMonth" => 0,
                     "industry" => "N/A",
                     "price" => 0.0,
                     "sector" => "N/A",
                     "symbol" => "N/A",
                     "symbolName" => " ",
                     "yearHigh" => 0.0,
                     "yearLow" => 0.0,
                     "amount" => 0.0,
                     "exDate" => " ",
                     "payDate" => " ",
                     "trailing_yield" => 0.0,
                     "forward_yield" => 0.0,
                     "frequency" => "QTR"
                     }

        conn 
        |> put_resp_content_type("text/plain")
        |> send_resp(200, Webapi.StockCache.Cache.stream()
                                |> Stream.map(fn(m) -> 

                                    m
                                    |> Map.get("dividends", {})
                                    |> latest_div()
                                    |> case do
                                        div when is_map(div) -> 
                                                trailing_yield = Webapi.Dividend.trailing_yield(m)
                                                forward_yield = Webapi.Dividend.forward_yield(m)

                                                m
                                                |> Map.drop(["dividends"])
                                                |> Map.merge(div)
                                                |> Map.merge(Webapi.Dividend.payQtrMonth(div))
                                                |> Map.put("trailing_yield", trailing_yield)
                                                |> Map.put("forward_yield", forward_yield)
                                        _ -> m
                                        end
                                    end)
                                |> Stream.map(fn(m) -> Map.merge(default, m) end)
                                |> CSV.Encoding.Encoder.encode(headers: true)
                                |> Enum.to_list)
    end

    defp latest_div(map) when map_size(map) == 0, do: map
    defp latest_div(map) when is_map(map) != true, do: map

    defp latest_div(map) when is_map(map) do
        map
        |> Map.to_list()
        |> List.foldl({}, &max_paydate/2)
        |> case do
            {_, div} -> div
        end
    end

    defp max_paydate(left, right) when tuple_size(right) == 0, do: left

    defp max_paydate(left, right) do
        {_, %{"payDate" => left_date}} = left
        {_, %{"payDate" => right_date}} = right

        case Date.compare(Date.from_iso8601!(left_date), Date.from_iso8601!(right_date)) do
            :lt -> right
            :gt -> left
            :eq -> right
        end
    end
end

