defmodule WebUi.StockController do
  use WebUi, :controller

  alias StockCraz.Securities
  alias StockCraz.Securities.Stock

  def index(conn, _params) do
    stocks = Securities.list_stocks()
    render(conn, "index.html", stocks: stocks)
  end

  def new(conn, _params) do
    changeset = Securities.change_stock(%Stock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock" => stock_params}) do
    case Securities.create_stock(stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock created successfully.")
        |> redirect(to: stock_path(conn, :show, stock))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"symbol" => symbol}) do
    stock = Securities.get_stock!(symbol)
    render(conn, "show.html", stock: stock)
  end

  def edit(conn, %{"symbol" => symbol}) do
    stock = Securities.get_stock!(symbol)
    changeset = Securities.change_stock(stock)
    render(conn, "edit.html", stock: stock, changeset: changeset)
  end

  def update(conn, %{"symbol" => symbol, "stock" => stock_params}) do
    stock = Securities.get_stock!(symbol)

    case Securities.update_stock(stock, stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock updated successfully.")
        |> redirect(to: stock_path(conn, :show, stock))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock: stock, changeset: changeset)
    end
  end

  def delete(conn, %{"symbol" => symbol}) do
    stock = Securities.get_stock!(symbol)
    {:ok, _stock} = Securities.delete_stock(stock)

    conn
    |> put_flash(:info, "Stock deleted successfully.")
    |> redirect(to: stock_path(conn, :index))
  end
end
