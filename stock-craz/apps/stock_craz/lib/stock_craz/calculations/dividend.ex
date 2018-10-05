defmodule StockCraz.Calculations.Dividend do
    
  alias StockCraz.Securities.DividendDeclaration

  @spec next_payment([%DividendDeclaration{}], Date.t) :: %DividendDeclaration{}
  def next_payment(dividends, base_date) do
    dividends
    |> List.foldl(%DividendDeclaration{}, &max_paydate/2)
  end

  defp max_paydate(%DividendDeclaration{:pay_date => left_date} = left, %DividendDeclaration{:pay_date => right_date} = right) when right_date == nil, do: left

  defp max_paydate(%DividendDeclaration{:pay_date => left_date} = left, %DividendDeclaration{:pay_date => right_date} = right) do
      case Date.compare(DateTime.to_date(left_date), right_date) do
          :lt -> right
          :gt -> left
          :eq -> right
      end
  end

  @spec pay_frequency([Date.t | %DividendDeclaration{}], Date.t) :: :MTH | :QTR | :BIA | :ANN | :STP
  def pay_frequency(items, base_date) do
    gte = &>=/2

    items
    |> Stream.map( fn 
        %DividendDeclaration{} = dividend -> DateTime.to_date(dividend.pay_date) 
        %Date{} = date -> date
    end)
    |> Enum.sort(gte)
    |> Stream.filter(fn(x) ->
      Date.diff(x, base_date)
      |> gte.(-365)
    end )
    |> Stream.transform(
      {},
      &transform_item/2
    )
    |> Enum.at(-1)
    |> period_to_frequency()
  end

  defp transform_item(pay_date, accumlator) do
    case accumlator do
      {} -> {[0], {0, 0, pay_date}}
      {0, counter, last_date} -> 
        build_transform_result(
          Date.diff(last_date, pay_date),
          counter + 1,
          pay_date)
      {sum, counter, last_date} -> 
        build_transform_result(
          sum + Date.diff(last_date, pay_date),
          counter + 1,
          pay_date)
    end
  end

  defp period_to_frequency(average_period) do
    cond do
      average_period == 0 -> :STP
      average_period < 50 -> :MTH
      average_period < 100 -> :QTR
      average_period < 215 -> :BIA
      average_period < 370 -> :ANN
      true -> :STP
    end
  end

  defp build_transform_result(sum, counter, last_date) do
    {
      [sum / counter],
      {
        sum,
        counter,
        last_date
      }
    }
  end

  def frq_multiplier(:MTH), do: 12
  def frq_multiplier(:QTR), do: 4
  def frq_multiplier(:BIA), do: 2
  def frq_multiplier(:ANN), do: 1
  def frq_multiplier(:STP), do: 0
  def frq_multiplier(_), do: 4
end
