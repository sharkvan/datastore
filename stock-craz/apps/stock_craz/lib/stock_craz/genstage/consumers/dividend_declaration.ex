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

    for {opteration, dividend_declaration, symbol} <- events do
      Task.start(__MODULE__, :handle_event, [opteration, dividend_declaration, symbol])
    end

    {:noreply, [], state}
  end

  defp handle_event(:insert, dividend_declaration, symbol) do
    case Securities.create_dividend_declaration(dividend_declaration, symbol) do
      {:error, _changeset} ->
        IO.inspect "Error inserting record"
        IO.inspect dividend_declaration
      {:ok, record} ->
        ViewStores.InvestmentViewServer.add(record)
    end
  end
end
