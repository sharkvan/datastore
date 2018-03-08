defmodule Webapi.Dividend do

    def trailing_yield(%{"price" => price, "dividends" => payments}) do
        today = Date.utc_today()
        gte = &>=/2
        yield = fn(x) -> x / String.to_float(price) end

        payments
        |> Stream.filter(fn(x) ->
                elem(x, 0)
                |> Date.from_iso8601!()
                |> Date.diff(today)
                |> gte.(-365)
            end)
        |> Enum.to_list()
        |> List.foldl(0.0, fn(x, acc) ->
                {_, %{"amount" => amount}} = x
                
                acc + String.to_float(amount)
            end)
        |> yield.()
        |> IO.inspect
    end

end
