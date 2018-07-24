defmodule WebUi.PortfolioControllerTest do
  use WebUi.ConnCase

  alias StockCraz.Portfolios
  alias StockCraz.Accounts

  @create_attrs %{name: "High Yield Dividend", user_id: 1}
  @update_attrs %{name: "High Yield Dividend 2x", user_id: 1}
  @invalid_attrs %{name: nil, user_id: nil}

  def fixture(:portfolio) do
    {:ok, portfolio} = Portfolios.create_portfolio(@create_attrs)
    portfolio
  end

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(%{email: "test.me@stockcraz.com"})
    user
  end

  describe "index" do
    test "lists all portfolios", %{conn: conn} do
      conn = fixture(conn, :sign_in)
             |> get(portfolio_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Portfolios"
    end
  end

  describe "new portfolio" do
    test "renders form", %{conn: conn} do
      conn = fixture(conn, :sign_in)
             |> get(portfolio_path(conn, :new))
      assert html_response(conn, 200) =~ "New Portfolio"
    end
  end

  describe "create portfolio" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = fixture(conn, :sign_in)
             |> post(portfolio_path(conn, :create), portfolio: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == portfolio_path(conn, :show, id)

      conn = get fixture(conn, :sign_in), portfolio_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Investments"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = fixture(conn, :sign_in)
             |> post(portfolio_path(conn, :create), portfolio: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Portfolio"
    end
  end

  describe "edit portfolio" do
    setup [:create_portfolio]

    test "renders form for editing chosen portfolio", %{conn: conn, portfolio: portfolio} do
      conn = fixture(conn, :sign_in)
             |> get(portfolio_path(conn, :edit, portfolio))
      assert html_response(conn, 200) =~ "Edit Portfolio"
    end
  end

  describe "update portfolio" do
    setup [:create_portfolio]

    test "redirects when data is valid", %{conn: conn, portfolio: portfolio} do
      conn = fixture(conn, :sign_in)
             |> put(portfolio_path(conn, :update, portfolio), portfolio: @update_attrs)
      assert redirected_to(conn) == portfolio_path(conn, :show, portfolio)

      conn = fixture(conn, :sign_in)
             |> get(portfolio_path(conn, :show, portfolio))
      assert html_response(conn, 200) =~ "High Yield Dividend 2x"
    end

    test "renders errors when data is invalid", %{conn: conn, portfolio: portfolio} do
      conn = fixture(conn, :sign_in)
             |> put(portfolio_path(conn, :update, portfolio), portfolio: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Portfolio"
    end
  end

  describe "delete portfolio" do
    setup [:create_portfolio]

    test "deletes chosen portfolio", %{conn: conn, portfolio: portfolio} do
      conn = fixture(conn, :sign_in)
             |> delete(portfolio_path(conn, :delete, portfolio))
      assert redirected_to(conn) == portfolio_path(conn, :index)
      assert_error_sent 404, fn ->
        get fixture(conn, :sign_in), portfolio_path(conn, :show, portfolio)
      end
    end
  end

  defp create_portfolio(_) do
    portfolio = fixture(:portfolio)
    {:ok, portfolio: portfolio}
  end
end
