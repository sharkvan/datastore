defmodule StockCraz.GenStage.Consumers.DividendDeclaration do
  use GenStage

  alias StockCraz.Securities
  alias StockCraz.Securities.DividendDeclaration

  def start_link do
    GenStage.start_link(__MODULE__, :no_state)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [StockCraz.GenStage.Producers.DividendDeclaration]}
  end

  def handle_events(events, _from, state) do
    IO.inspect ("Handle events")
    for {dividend_declaration, symbol} <- events do
      Securities.create_dividend_declaration(dividend_declaration, symbol)
      |> IO.inspect
    end

    {:noreply, [], state}
  end

end
