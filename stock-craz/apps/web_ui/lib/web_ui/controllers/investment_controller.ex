defmodule WebUi.InvestmentController do
  use WebUi, :controller

  alias StockCraz.Portfolios
  alias StockCraz.Portfolios.Investment

  def index(conn, _params) do
    investments = Portfolios.list_investments()
    render(conn, "index.html", investments: investments)
  end

  def new(conn, _params) do
    changeset = Portfolios.change_investment(%Investment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"investment" => investment_params}) do
    case Portfolios.create_investment(investment_params) do
      {:ok, investment} ->
        conn
        |> put_flash(:info, "Investment created successfully.")
        |> redirect(to: investment_path(conn, :show, investment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    investment = Portfolios.get_investment!(id)
    render(conn, "show.html", investment: investment)
  end

  def edit(conn, %{"id" => id}) do
    investment = Portfolios.get_investment!(id)
    changeset = Portfolios.change_investment(investment)
    render(conn, "edit.html", investment: investment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "investment" => investment_params}) do
    investment = Portfolios.get_investment!(id)

    case Portfolios.update_investment(investment, investment_params) do
      {:ok, investment} ->
        conn
        |> put_flash(:info, "Investment updated successfully.")
        |> redirect(to: investment_path(conn, :show, investment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", investment: investment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    investment = Portfolios.get_investment!(id)
    {:ok, _investment} = Portfolios.delete_investment(investment)

    conn
    |> put_flash(:info, "Investment deleted successfully.")
    |> redirect(to: investment_path(conn, :index))
  end
end
