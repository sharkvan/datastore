defmodule StockCraz.GenStage.Consumers.StockPrice do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :no_state)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [StockCraz.GenStage.Producers.StockPrice]}
  end

  def handle_events(events, _from, state) do
    IO.inspect ("Handle events")
    for event <- events do
      IO.inspect ({self(), event, state})
    end

    {:noreply, [], state}
  end

end
