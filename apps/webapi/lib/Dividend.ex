defmodule Webapi.Dividend do

    def trailing_yield(%{"price" => price, "dividends" => payments}) do
        today = Date.utc_today()
        gte = &>=/2

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
        |> yield(price)
        |> IO.inspect
    end

    defp yield(amount, price) do
        IO.inspect {:price, price}
        IO.inspect {:amount, amount}

        Float.parse(price)
        |> case do
            {^price, _} -> amount / ^price
            :error -> 0
        end
    end
end
