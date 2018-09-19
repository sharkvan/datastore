defmodule StockCraz.Utilities.Dates do

  def gtrMonth(%DateTime{} = date) do
    qtrMonth(date.month)
  end

  def qtrMonth(date) when is_binary(date) do
    case DateTime.from_iso8601(date) do
      {:ok, date, _} -> qtrMonth(date.month)
      {:error, _} -> 0
    end
  end

  def qtrMonth(0), do: 0
  def qtrMonth(date) when date in [1, 4, 7, 10], do: 1
  def qtrMonth(date) when date in [2, 5, 8, 11], do: 2
  def qtrMonth(date) when date in [3, 6, 9, 12], do: 3

  def quarter(%DateTime{} = date) do
    quarter(date.month)
  end

  def quarter(date) when is_binary(date) do
    case DateTime.from_iso8601(date) do
      {:ok, date, _} -> quarter(date)
      {:error, _} -> 0
    end
  end
  def quarter(month) when month in [1, 2, 3], do: 1
  def quarter(month) when month in [4, 5, 6], do: 2
  def quarter(month) when month in [7, 8, 9], do: 3
  def quarter(month) when month in [10, 11, 12], do: 4
end
