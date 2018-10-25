defmodule StockCraz.EventProducers.Sync.DividendDeclaration do
  @behavior StockCraz.EventProducer

  alias StockCraz.Securities

  def send_event(data, timeout \\ 5000) do
    case data do
      {:insert, div, symbol} -> 
        Securities.create_dividend_declaration(div, symbol)
    end
  end

end
