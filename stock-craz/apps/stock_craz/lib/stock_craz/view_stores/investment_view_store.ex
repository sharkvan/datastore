defmodule StockCraz.ViewStores.InvestmentViewStore do
  
  alias StockCraz.Portfolios.InvestmentViewModel
  alias StockCraz.Securities.DividendDeclaration

  def create_table() do
    :ets.new(
      :investment_view_store, 
      [:named_table,
       :set,
       :private,
       read_concurrency: true])
    :ok
  end

  def set(%InvestmentViewModel{} = record) do
    :ets.insert(:investment_view_store, {record.symbol, record})
  end

  def update(%DividendDeclaration{symbol: symbol} = dividend_declaration, %Date{} = base_date) do
    case get(symbol) do
      {:error, _} -> :no_work
      {:ok, %InvestmentViewModel{ex_date: nil} = investment} -> apply_update(investment, dividend_declaration)
      {:ok, %InvestmentViewModel{pay_date: current_pay_date} = investment} ->

        case Date.compare(current_pay_date, base_date) do
          :lt -> apply_update(investment, dividend_declaration)            #potential_dividend
            #shares * quarterly avg * 4

            #projected_dividend 
            #if pay date is within current quarter boundary
            #and the pay date is less than or equal to the base_date
            #then amount * shares
        end
    end
    |> set()
  end

  defp apply_update(%InvestmentViewModel{} = investment, %DividendDeclaration{amount: amount, ex_date: ex_date, pay_date: pay_date}) do
    %{investment | dividend_amount: amount,
      ex_date: ex_date,
      pay_date: pay_date}
  end

  def get(symbol) do
    case :ets.lookup(:investment_view_store, symbol) do
      [{^symbol, investment}] -> {:ok, investment}
      [] -> {:error, "No investment record for the given symbol"}
    end
  end

  def first() do
    :ets.first(:investment_view_store)
  end

  def next(:"$end_of_table") do
    {:halt, nil}
  end

  def next(key) do
    next_key = :ets.next(:investment_view_store, key)
    value = :ets.lookup(:investment_view_store, key)
            |> Enum.map(&elem(&1, 1))

    {value, next_key}
  end
end
