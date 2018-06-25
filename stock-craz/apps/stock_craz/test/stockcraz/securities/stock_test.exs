defmodule StockCraz.StockTest do
  use StockCraz.DataCase

  alias StockCraz.Securities

  describe "Add and update stock" do
    alias StockCraz.Securities.Stock

    @valid_attrs %{symbol: "OXLC", name: "Oxford Lane Capital Corp.", price: 11.56, eps: 0, price_high_year: 11.40, price_low_year: 9.11}
    @update_attrs %{symbol: "OXLC", name: "Oxford Lane Capital Corp.", price: 11.56, eps: 0, price_high_year: 11.56, price_low_year: 9.11}
    @invalid_attrs %{symbol: ""}
    @missing_attrs %{symbol: nil}

    def stock_fixture(attrs \\ %{}) do
      {:ok, stock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Securities.create_stock()

      stock
    end

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Securities.list_stocks() == [stock]
    end

    test "get_stock/1 returns the stock with given symbol" do
      stock = stock_fixture()
      assert Securities.get_stock(stock.symbol) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      assert {:ok, %Stock{} = stock} = Securities.create_stock(@valid_attrs)
      assert stock.symbol == "OXLC"
    end

    test "create_stock/1 with invalid symbol returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Securities.create_stock(@invalid_attrs)
    end

    test "create_stock/1 with missing data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Securities.create_stock(@missing_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      assert {:ok, stock} = Securities.update_stock(stock, @update_attrs)
      assert %Stock{} = stock
      assert stock.price_high_year == Decimal.new(11.56)
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Securities.update_stock(stock, @invalid_attrs)
      assert stock == Securities.get_stock(stock.symbol)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Securities.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Securities.get_stock!(stock.symbol) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Securities.change_stock(stock)
    end
  end
end
