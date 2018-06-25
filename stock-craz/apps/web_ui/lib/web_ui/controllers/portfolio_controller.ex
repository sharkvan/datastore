defmodule WebUi.PortfolioController do
  use WebUi, :controller

  alias StockCraz.Portfolios
  alias StockCraz.Portfolios.Portfolio

  def index(conn, _params) do
    portfolios = Portfolios.list_portfolios()
    render(conn, "index.html", portfolios: portfolios)
  end

  def new(conn, _params) do
    changeset = Portfolios.change_portfolio(%Portfolio{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"portfolio" => portfolio_params}) do
    case Portfolios.create_portfolio(portfolio_params) do
      {:ok, portfolio} ->
        conn
        |> put_flash(:info, "Portfolio created successfully.")
        |> redirect(to: portfolio_path(conn, :show, portfolio))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    portfolio = Portfolios.get_portfolio!(id)
    render(conn, "show.html", portfolio: portfolio)
  end

  def edit(conn, %{"id" => id}) do
    portfolio = Portfolios.get_portfolio!(id)
    changeset = Portfolios.change_portfolio(portfolio)
    render(conn, "edit.html", portfolio: portfolio, changeset: changeset)
  end

  def update(conn, %{"id" => id, "portfolio" => portfolio_params}) do
    portfolio = Portfolios.get_portfolio!(id)

    case Portfolios.update_portfolio(portfolio, portfolio_params) do
      {:ok, portfolio} ->
        conn
        |> put_flash(:info, "Portfolio updated successfully.")
        |> redirect(to: portfolio_path(conn, :show, portfolio))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", portfolio: portfolio, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    portfolio = Portfolios.get_portfolio!(id)
    {:ok, _portfolio} = Portfolios.delete_portfolio(portfolio)

    conn
    |> put_flash(:info, "Portfolio deleted successfully.")
    |> redirect(to: portfolio_path(conn, :index))
  end
end
