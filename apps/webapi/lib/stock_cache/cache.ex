defmodule Webapi.StockCache.Cache do
    use GenServer

    def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, [
            {:ets_table_name, :stock_cache_table},
            {:log_limit, 1_000_000}
        ], opts)
    end

    def fetch(ticker, default_value_function) do
        case get(ticker) do
            {:not_found} -> set(ticker, default_value_function.())
            {:found, result} -> result
        end
    end

    def get(ticker) do
        case GenServer.call(__MODULE__, {:get, ticker}) do
            [] -> {:not_found}
            [{_ticker, result}] -> {:found, result}
        end
    end

    def set(ticker, value) do
        GenServer.call(__MODULE__, {:set, ticker, value})
    end

    # GenServer callbacks

    def handle_call({:get, ticker}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        result = :ets.lookup(ets_table_name, ticker)
        {:reply, result, state}
    end

    def handle_call({:set, ticker, value}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        true = :ets.insert(ets_table_name, {ticker, value})
        {:reply, value, state}
    end

    def init(args) do
        [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args

        :ets.new(ets_table_name, [:named_table, :set, :private])

        {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
    end
end
