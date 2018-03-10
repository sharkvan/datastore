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
        |> List.first()
        |> getDiv()
        |> Map.get("amount", "0")
        |> payout_guess.(frequency)
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

    def payQtrMonth(%{"payDate" => payDate}) do
        qtrMonth = case payDate do
            <<year::binary-size(4), "-", month::binary-size(2), "-", day::binary>> -> month
            _ -> "00"
        end
        |> case do
            "00" -> 0
            m when m in ["01", "04", "07", "10"] -> 1
            m when m in ["02", "05", "08", "11"] -> 2
            m when m in ["03", "06", "09", "12"] -> 3
        end

        %{"qtrMonth" => qtrMonth}
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
