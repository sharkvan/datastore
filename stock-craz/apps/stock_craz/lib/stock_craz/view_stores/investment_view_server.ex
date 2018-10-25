defmodule StockCraz.ViewStores.InvestmentViewServer do
  use GenServer

  alias StockCraz.ViewStores.InvestmentViewStore

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(args) do
    InvestmentViewStore.create_table()
    {:ok, %{log_limit: 1_000_000}}
  end

  def add(record) do
    GenServer.cast(__MODULE__, {:add, record})
  end

  def handle_call({:add, record}, _from, state) do
    InvestmentViewStore.update(record)
    {:noreply, {}, state}
  end
end
