defmodule StockCraz.ViewStores.InvestmentViewStoreTests do
  use ExUnit.Case

  alias StockCraz.ViewStores.InvestmentViewStore
  alias StockCraz.Portfolios.InvestmentViewModel
  alias StockCraz.Securities.DividendDeclaration

  describe "DividendDeclaration updates" do
    setup do
      InvestmentViewStore.create_table()
      InvestmentViewStore.set(
        %InvestmentViewModel{
          portfolio_id: 10, 
          symbol: "ABC"})
      :ok
    end

    test "when the current pay date is not set" do
      assert %DividendDeclaration{
        symbol: "ABC",
        amount: 0.52,
        dec_date: DateTime.from_iso8601("2018-01-05T00:00:00Z") |> elem(1),
        ex_date: DateTime.from_iso8601("2018-01-12T00:00:00Z") |> elem(1),
        rec_date: DateTime.from_iso8601("2018-01-16T00:00:00Z") |> elem(1),
        pay_date: DateTime.from_iso8601("2018-01-24T00:00:00Z") |> elem(1)}
      |> InvestmentViewStore.update(~D[2018-01-18])

      case InvestmentViewStore.get("ABC") do
        {:error, _} -> flunk "we should have recieved something"
        {:ok, %{ex_date: ex_date, pay_date: pay_date, dividend_amount: amount}} ->
          assert amount == 0.52
          assert ex_date == DateTime.from_iso8601("2018-01-12T00:00:00Z") |> elem(1)
          assert pay_date == DateTime.from_iso8601("2018-01-24T00:00:00Z") |> elem(1)
      end
    end
  end

  describe "Investment is" do
    setup do
      InvestmentViewStore.create_table()
      {:ok, msg: "nothing"}
    end

    test "added to the view", state do
      assert InvestmentViewStore.set(%InvestmentViewModel{portfolio_id: 10, symbol: "ABC"})
        
      case InvestmentViewStore.get("ABC") do
        {:ok, investment} -> 
          assert "ABC" == investment.symbol
          assert 10 == investment.portfolio_id
        {:error, _msg} -> 
          flunk "The record was not found"
      end
    end

    test "not found in the view", state do
      assert InvestmentViewStore.set(%InvestmentViewModel{portfolio_id: 10, symbol: "ABC"})

      case InvestmentViewStore.get("XYZ") do
        {:ok, investment} ->
          flunk "This should have returned an error"
        {:error, msg} ->
          assert true
      end
    end

  end

  describe "Test stream methods" do
    test "when there are no records in the view" do
    end

    test "when there is one record in the view" do
    end

    test "when there is more than one record in the view" do
    end
  end
end
