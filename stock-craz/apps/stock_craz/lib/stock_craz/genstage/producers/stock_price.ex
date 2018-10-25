defmodule StockCraz.GenStage.Producers.StockPrice do
  use GenStage

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer, :ok, dispatcher: GenStage.BroadcastDispatcher}
  end

  def send_data(data, timeout \\ 5000) do
    GenStage.call(__MODULE__, {:notify, data}, timeout)
  end

  def handle_call({:notify, data}, _from, state) do
    {:reply, :ok, data, state}
  end

  def handle_demand(demand, state) do
    IO.inspect("handle more demand #{demand}")
    {:noreply, [], state}
  end
end
