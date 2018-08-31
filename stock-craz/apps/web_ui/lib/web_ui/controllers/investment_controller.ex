defmodule WebUi.InvestmentController do
  use WebUi, :controller

  alias StockCraz.Portfolios
  alias StockCraz.Portfolios.Investment

  # Need to add an authorization plug here
  # for the current user to make sure they own the
  # portfolio that is being requested.

  def index(conn, %{"portfolio_id" => portfolio_id}) do
    investments = Portfolios.list_investment_views(portfolio_id)
    render(conn, "index.html", investments: investments, portfolio_id: portfolio_id)
  end

  def new(conn, %{"portfolio_id" => portfolio_id}) do
    changeset = Portfolios.change_investment(%Investment{})
    render(conn, "new.html", changeset: changeset)
  end

  defp get_or_create_Stock(%{"symbol" => nil} = investment), do: investment

  defp get_or_create_Stock(investment) do
    stock = StockCraz.Securities.get_stock(investment["symbol"])
    |> case do
      nil -> 
        case StockCraz.Securities.create_stock(%{symbol: investment["symbol"]}) do
          {:ok, stock} -> stock
          {:error, _} -> nil
        end
      stock -> stock
    end

    Map.put(investment, "stock_id", stock.id)
  end

  def create(conn, %{"investment" => investment_params, "portfolio_id" => portfolio_id}) do

    Map.put(investment_params, "portfolio_id", portfolio_id)
    |> get_or_create_Stock()
    |> Portfolios.create_investment()
    |> case do
         {:ok, investment} ->
           conn
           |> put_flash(:info, "Investment created successfully.")
           |> redirect(to: portfolio_investment_path(conn, :show, portfolio_id, investment))
         {:error, %Ecto.Changeset{} = changeset} ->
           render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "portfolio_id" => portfolio_id}) do
    investment = Portfolios.get_investment!(id)
    render(conn, "show.html", investment: investment, portfolio_id: portfolio_id)
  end

  def edit(conn, %{"id" => id, "portfolio_id" => portfolio_id}) do
    investment = Portfolios.get_investment!(id)
    changeset = Portfolios.change_investment(investment)
    render(conn, "edit.html", investment: investment, changeset: changeset, portfolio_id: portfolio_id)
  end

  def update(conn, %{"id" => id, "investment" => investment_params, "portfolio_id" => portfolio_id}) do
    investment_params = get_or_create_Stock(investment_params)
    investment = Portfolios.get_investment!(id)
    Portfolios.update_investment(investment, investment_params)
    |> case do
      {:ok, investment} ->
        conn
        |> put_flash(:info, "Investment updated successfully.")
        |> redirect(to: portfolio_investment_path(conn, :show, portfolio_id, investment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", investment: investment, changeset: changeset, portfolio_id: portfolio_id)
    end
  end

  def delete(conn, %{"id" => id, "portfolio_id" => portfolio_id}) do
    investment = Portfolios.get_investment!(id)
    {:ok, _investment} = Portfolios.delete_investment(investment)

    conn
    |> put_flash(:info, "Investment deleted successfully.")
    |> redirect(to: portfolio_investment_path(conn, :index, portfolio_id))
  end
end
