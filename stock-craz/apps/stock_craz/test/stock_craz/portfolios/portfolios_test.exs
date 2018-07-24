defmodule StockCraz.PortfoliosTest do
  use StockCraz.DataCase

  alias StockCraz.Portfolios

  describe "portfolios" do
    alias StockCraz.Portfolios.Portfolio

    @valid_attrs %{name: "some name", user_id: 1}
    @update_attrs %{name: "some updated name", user_id: 1}
    @invalid_attrs %{name: nil, user_id: nil}

    def portfolio_fixture(attrs \\ %{}) do
      {:ok, portfolio} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portfolios.create_portfolio()

      portfolio
    end

    test "list_portfolios/0 returns all portfolios" do
      portfolio = portfolio_fixture()
      assert Portfolios.list_portfolios() == [portfolio]
    end

    test "get_portfolio!/1 returns the portfolio with given id" do
      portfolio = portfolio_fixture()
      assert Portfolios.get_portfolio!(portfolio.id) == portfolio
    end

    test "create_portfolio/1 with valid data creates a portfolio" do
      assert {:ok, %Portfolio{} = portfolio} = Portfolios.create_portfolio(@valid_attrs)
      assert portfolio.name == "some name"
      assert portfolio.user_id == 1
    end

    test "create_portfolio/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolios.create_portfolio(@invalid_attrs)
    end

    test "update_portfolio/2 with valid data updates the portfolio" do
      portfolio = portfolio_fixture()
      assert {:ok, portfolio} = Portfolios.update_portfolio(portfolio, @update_attrs)
      assert %Portfolio{} = portfolio
      assert portfolio.name == "some updated name"
      assert portfolio.user_id == 1
    end

    test "update_portfolio/2 with invalid data returns error changeset" do
      portfolio = portfolio_fixture()
      assert {:error, %Ecto.Changeset{}} = Portfolios.update_portfolio(portfolio, @invalid_attrs)
      assert portfolio == Portfolios.get_portfolio!(portfolio.id)
    end

    test "delete_portfolio/1 deletes the portfolio" do
      portfolio = portfolio_fixture()
      assert {:ok, %Portfolio{}} = Portfolios.delete_portfolio(portfolio)
      assert_raise Ecto.NoResultsError, fn -> Portfolios.get_portfolio!(portfolio.id) end
    end

    test "change_portfolio/1 returns a portfolio changeset" do
      portfolio = portfolio_fixture()
      assert %Ecto.Changeset{} = Portfolios.change_portfolio(portfolio)
    end
  end

  describe "investments" do
    alias StockCraz.Portfolios.Investment

    @valid_attrs %{cost_basis: "120.5", investment_date: "2010-04-17 14:00:00.000000Z", shares: "120.5", starting_shares: 42, stock_id: 42, portfolio_id: 42, target_roi: "120.5"}
    @update_attrs %{cost_basis: "456.7", investment_date: "2011-05-18 15:01:01.000000Z", shares: "456.7", starting_shares: 43, stock_id: 43, portfolio_id: 42, target_roi: "456.7"}
    @invalid_attrs %{cost_basis: nil, investment_date: nil, shares: nil, starting_shares: nil, stock_id: nil, portfolio_id: nil, target_roi: nil}

    def investment_fixture(attrs \\ %{}) do
      {:ok, investment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portfolios.create_investment()

      investment
    end

    test "list_investments/0 returns all investments" do
      investment = investment_fixture()
      assert Portfolios.list_investments(42) == [investment]
    end

    test "get_investment!/1 returns the investment with given id" do
      investment = investment_fixture()
      assert Portfolios.get_investment!(investment.id) == investment
    end

    test "create_investment/1 with valid data creates a investment" do
      assert {:ok, %Investment{} = investment} = Portfolios.create_investment(@valid_attrs)
      assert investment.cost_basis == Decimal.new("120.5")
      assert investment.investment_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert investment.shares == Decimal.new("120.5")
      assert investment.starting_shares == 42
      assert investment.stock_id == 42
      assert investment.target_roi == Decimal.new("120.5")
    end

    test "create_investment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolios.create_investment(@invalid_attrs)
    end

    test "update_investment/2 with valid data updates the investment" do
      investment = investment_fixture()
      assert {:ok, investment} = Portfolios.update_investment(investment, @update_attrs)
      assert %Investment{} = investment
      assert investment.cost_basis == Decimal.new("456.7")
      assert investment.investment_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert investment.shares == Decimal.new("456.7")
      assert investment.starting_shares == 43
      assert investment.stock_id == 43
      assert investment.target_roi == Decimal.new("456.7")
    end

    test "update_investment/2 with invalid data returns error changeset" do
      investment = investment_fixture()
      assert {:error, %Ecto.Changeset{}} = Portfolios.update_investment(investment, @invalid_attrs)
      assert investment == Portfolios.get_investment!(investment.id)
    end

    test "delete_investment/1 deletes the investment" do
      investment = investment_fixture()
      assert {:ok, %Investment{}} = Portfolios.delete_investment(investment)
      assert_raise Ecto.NoResultsError, fn -> Portfolios.get_investment!(investment.id) end
    end

    test "change_investment/1 returns a investment changeset" do
      investment = investment_fixture()
      assert %Ecto.Changeset{} = Portfolios.change_investment(investment)
    end
  end
end
