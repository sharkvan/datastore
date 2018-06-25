defmodule WebUi.InvestmentControllerTest do
  use WebUi.ConnCase

  alias StockCraz.Portfolios

  @create_attrs %{cost_basis: "120.5", investment_date: "2010-04-17 14:00:00.000000Z", shares: "110.5", starting_shares: 40, stock_id: 41, portfolio_id: 42, target_roi: "100.5"}
  @update_attrs %{cost_basis: "456.7", investment_date: "2011-05-18 15:01:01.000000Z", shares: "456.7", starting_shares: 43, stock_id: 43, portfolio_id: 42, target_roi: "456.7"}
  @invalid_attrs %{cost_basis: nil, investment_date: nil, shares: nil, starting_shares: nil, stock_id: nil, portfolio_id: nil, target_roi: nil}

  def fixture(:investment) do
    {:ok, investment} = Portfolios.create_investment(@create_attrs)
    investment
  end

  describe "index" do
    test "lists all investments", %{conn: conn} do
      conn = get conn, investment_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Investments"
    end
  end

  describe "new investment" do
    test "renders form", %{conn: conn} do
      conn = get conn, investment_path(conn, :new)
      assert html_response(conn, 200) =~ "New Investment"
    end
  end

  describe "create investment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, investment_path(conn, :create), investment: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == investment_path(conn, :show, id)

      conn = get conn, investment_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Investment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, investment_path(conn, :create), investment: @invalid_attrs
      assert html_response(conn, 200) =~ "New Investment"
    end
  end

  describe "edit investment" do
    setup [:create_investment]

    test "renders form for editing chosen investment", %{conn: conn, investment: investment} do
      conn = get conn, investment_path(conn, :edit, investment)
      assert html_response(conn, 200) =~ "Edit Investment"
    end
  end

  describe "update investment" do
    setup [:create_investment]

    test "redirects when data is valid", %{conn: conn, investment: investment} do
      conn = put conn, investment_path(conn, :update, investment), investment: @update_attrs
      assert redirected_to(conn) == investment_path(conn, :show, investment)

      conn = get conn, investment_path(conn, :show, investment)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, investment: investment} do
      conn = put conn, investment_path(conn, :update, investment), investment: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Investment"
    end
  end

  describe "delete investment" do
    setup [:create_investment]

    test "deletes chosen investment", %{conn: conn, investment: investment} do
      conn = delete conn, investment_path(conn, :delete, investment)
      assert redirected_to(conn) == investment_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, investment_path(conn, :show, investment)
      end
    end
  end

  defp create_investment(_) do
    investment = fixture(:investment)
    {:ok, investment: investment}
  end
end
