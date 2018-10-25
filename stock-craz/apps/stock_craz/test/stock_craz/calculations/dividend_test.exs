defmodule StockCraz.Calculations.DividendTest do
  use ExUnit.Case

  alias StockCraz.Calculations.Dividend
  alias StockCraz.Securities.DividendDeclaration

  describe "Quarterly payments when" do
    setup do
      %{
        :pay_dates => [~D[2018-01-15], 
                       ~D[2018-04-15], 
                       ~D[2018-07-15],
                       ~D[2018-09-15]
        ]
      }
    end

    test "base date is after last payment", %{:pay_dates => pay_dates} do
      base_date = ~D[2018-10-15]
      assert :QTR == Dividend.pay_frequency(pay_dates, base_date)
    end

    test "base date is on last payment", %{:pay_dates => pay_dates} do
      base_date = ~D[2018-09-15]
      assert :QTR == Dividend.pay_frequency(pay_dates, base_date)
    end

    test "base date is before last payment", %{:pay_dates => pay_dates} do
      base_date = ~D[2018-06-15]
      assert :QTR == Dividend.pay_frequency(pay_dates, base_date)
    end
  end

  describe "Monthly payments when" do
    setup do
      %{
        :pay_dates => [~D[2018-01-15],
                       ~D[2018-02-15],
                       ~D[2018-03-15],
                       ~D[2018-04-15],
                       ~D[2018-05-15],
                       ~D[2018-06-15]
        ]
      }
    end

    test "base dates is after last payment", %{:pay_dates => pay_dates} do
      base_date = ~D[2018-06-25]
      assert :MTH == Dividend.pay_frequency(pay_dates, base_date)
    end

    test "base date is before last payment", %{:pay_dates => pay_dates} do
      base_date = ~D[2018-06-01]
      assert :MTH == Dividend.pay_frequency(pay_dates, base_date)
    end
  end

  describe "Return the next dividend payment" do
    setup do
      %{
        :dividends => [
          %DividendDeclaration{:id => 1, :pay_date => DateTime.from_iso8601("2018-01-15T00:00:00Z") |> elem(1)},
          %DividendDeclaration{:id => 2, :pay_date => DateTime.from_iso8601("2018-02-15T00:00:00Z") |> elem(1)},
          %DividendDeclaration{:id => 3, :pay_date => DateTime.from_iso8601("2018-03-15T00:00:00Z") |> elem(1)},
          %DividendDeclaration{:id => 4, :pay_date => DateTime.from_iso8601("2018-04-15T00:00:00Z") |> elem(1)},
          %DividendDeclaration{:id => 5, :pay_date => DateTime.from_iso8601("2018-05-15T00:00:00Z") |> elem(1)},
          %DividendDeclaration{:id => 6, :pay_date => DateTime.from_iso8601("2018-06-15T00:00:00Z") |> elem(1)},  
          %DividendDeclaration{:id => 7, :pay_date => DateTime.from_iso8601("2018-07-15T00:00:00Z") |> elem(1)},
          %DividendDeclaration{:id => 8, :pay_date => DateTime.from_iso8601("2018-08-15T00:00:00Z") |> elem(1)}
        ]
      }
    end

    test "base date is before last payment", %{:dividends => dividends} do
      base_date = ~D[2018-06-01]
      assert :MTH == Dividend.pay_frequency(dividends, base_date)
    end

    test "when base date is in last reported month", %{:dividends => dividends} do
      base_date = ~D[2018-08-05]
      result = Dividend.next_payment(dividends, base_date)
      assert 8 == result.id
    end
  end
end
