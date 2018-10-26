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

  def stream() do
    Stream.resource(
      fn -> GenServer.call(__MODULE__, {:first}) end,
      fn key -> GenServer.call(__MODULE__, {:next, key}) end,
      fn _key -> end)
  end

  def handle_call({:first}, _from, state) do
    {:reply, InvestmentViewStore.first(), state}
  end

  def handle_call({:next, key}, _from, state) do
    {:reply, InvestmentViewStore.next(key), state}
  end

  def handle_call({:add, record}, _from, state) do
    InvestmentViewStore.update(record)
    {:noreply, {}, state}
  end
end
