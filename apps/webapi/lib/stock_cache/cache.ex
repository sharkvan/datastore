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

    def delete(ticker) do
        GenServer.call(__MODULE__, {:delete, ticker})
    end

    def stream() do
        Stream.resource(
            GenServer.call(__MODULE__, {:first}),
            &fetch_record/1,
            &close_stream/1)
    end

    defp fetch_record(:"$end_of_table") do
        {:halt, nil}
    end
   
    defp fetch_record(key) do
        GenServer.call(__MODULE__, {:next, key})
    end

    defp close_stream(_key) do
    end

    # GenServer callbacks

    def handle_call({:next, key}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        
        value = :ets.lookup(ets_table_name, key)
        |> Enum.map(&(elem(&1, 1)))
        
        next_key = :ets.next(ets_table_name, key)
        
        {:reply, {value, next_key}, state}
    end

    def handle_call({:first}, _from, state) do
        %{ets_table_name: ets_table_name} = state

        key = :ets.first(ets_table_name)
        result = fn -> key end

        {:reply, result, state}
    end

    def handle_call({:set, ticker, value}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        true = :ets.insert(ets_table_name, {ticker, value})
        {:reply, value, state}
    end

    def handle_call({:get, ticker}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        result = :ets.lookup(ets_table_name, ticker)
        {:reply, result, state}
    end

    def handle_call({:delete, ticker}, _from, state) do
        %{ets_table_name: ets_table_name} = state
        result = :ets.delete(ets_table_name, ticker)
        {:reply, result, state}
    end

    def init(args) do
        [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args

        :ets.new(ets_table_name, [:named_table, :set, :private])

        {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
    end
end
