defmodule Webapi.Dividend do

    def forward_yield(%{"price" => price, "frequency" => frequency, "dividends" => payments}) do
        today = Date.utc_today()
        gte = &>=/2
        payout_guess = fn(x, frequency) -> 
            Float.parse(x)
            |> case do
                :error -> 0
                {amount, _} -> amount * multiplier(frequency)
            end
        end

        payments
        |> Stream.filter(fn(x) ->
                elem(x, 0)
                |> Date.from_iso8601!()
                |> Date.diff(today)
                |> gte.(-365)
            end)
        |> Enum.to_list()
        |> Enum.sort_by(fn(x) -> elem(x, 0) end, &>=/2)
        |> IO.inspect
        |> List.first()
        |> IO.inspect
        |> getDiv()
        |> IO.inspect
        |> Map.get("amount", "0")
        |> IO.inspect
        |> payout_guess.(frequency)
        |> IO.inspect
        |> yield(price)
    end

    defp getDiv(record) do
        case record do
            nil -> %{}
            _ -> elem(record, 1)
        end
    end

    def forward_yield(%{"price" => price, "dividends" => payments}) do
        forward_yield(%{"price" => price, "frequency" => "QTR", "dividends" => payments})
    end

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

    defp multiplier(frequency) do
        case frequency do
            "MTH" -> 12
            "QTR" -> 4
            "BIA" -> 2
            "ANN" -> 1
            "STP" -> 0
            _ -> 4
        end
    end

    defp yield(amount, price) do
        IO.inspect {:price, price}
        IO.inspect {:amount, amount}

        Float.parse(price)
        |> case do
            {0.0, _} -> 0
            {price, _} -> amount / price
            :error -> 0
        end
    end
end
