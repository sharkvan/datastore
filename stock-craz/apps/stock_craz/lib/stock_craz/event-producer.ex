defmodule StockCraz.EventProducer do
  @callback send_event(data :: any, timeout :: integer) :: {:ok, any} | {:error, any}
end
