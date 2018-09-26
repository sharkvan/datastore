defmodule StockCraz.Calculations.Dividend do
    
  @spec pay_frequency(Date.t, [Date.t]) :: :MTH | :QTR | :BIA | :ANN | :STP
  def pay_frequency(baseDate, payDates) do
    gte = &>=/2

    payDates
    |> Enum.sort(gte)
    |> Stream.filter(fn(x) ->
      Date.diff(x, baseDate)
      |> gte.(-365)
    end )
    |> Stream.transform(
      {},
      fn 
        pay_date, {} -> {0, {0, 0, pay_date}}
        pay_date, {0, 0, last_date} ->
          {
            Date.diff(last_date, pay_date),
            1,
            pay_date
          }
        pay_date, {sum, counter, last_date} -> 
          sum = sum + Date.diff(last_date, pay_date)
          {
            sum / counter,
            {
              sum,
              counter+1,
              pay_date
            }
          }
      end
    )
    |> Enum.to_list() 
    # |> Enum.reduce(
    # #  {},
    # #  fn
    # #    distance, {} -> {distance, 1}
    # #    distance, {sum, counter} ->
    # #      {sum + distance, counter + 1}
    # #  end
    # #)
    # #|> (fn {sum, counter} ->
    # #  sum / counter
    # #end).()
    # I need an accumulator that will take the
    # previous item and current item and return the
    # distance between the two dates. Then I should 
    # have a list of distances. Looking at the first 
    # item and the average of the last four items
    # I should be able to determine the frequency.
    #
  end

  def frq_multiplier("MTH"), do: 12
  def frq_multiplier("QTR"), do: 4
  def frq_multiplier("BIA"), do: 2
  def frq_multiplier("ANN"), do: 1
  def frq_multiplier("STP"), do: 0
  def frq_multiplier(_), do: 4
end
