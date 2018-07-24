defmodule WebUi.DividendDeclarationController do
  use WebUi, :controller

  alias StockCraz.Securities
  alias StockCraz.Securities.DividendDeclaration

  def index(conn, _params) do
    dividend_declarations = Securities.list_dividend_declarations()
    render(conn, "index.html", dividend_declarations: dividend_declarations)
  end

  def new(conn, _params) do
    changeset = Securities.change_dividend_declaration(%DividendDeclaration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dividend_declaration" => dividend_declaration_params}) do
    case Securities.create_dividend_declaration(dividend_declaration_params) do
      {:ok, dividend_declaration} ->
        conn
        |> put_flash(:info, "Dividend declaration created successfully.")
        |> redirect(to: dividend_declaration_path(conn, :show, dividend_declaration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)
    render(conn, "show.html", dividend_declaration: dividend_declaration)
  end

  def edit(conn, %{"id" => id}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)
    changeset = Securities.change_dividend_declaration(dividend_declaration)
    render(conn, "edit.html", dividend_declaration: dividend_declaration, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dividend_declaration" => dividend_declaration_params}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)

    case Securities.update_dividend_declaration(dividend_declaration, dividend_declaration_params) do
      {:ok, dividend_declaration} ->
        conn
        |> put_flash(:info, "Dividend declaration updated successfully.")
        |> redirect(to: dividend_declaration_path(conn, :show, dividend_declaration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", dividend_declaration: dividend_declaration, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)
    {:ok, _dividend_declaration} = Securities.delete_dividend_declaration(dividend_declaration)

    conn
    |> put_flash(:info, "Dividend declaration deleted successfully.")
    |> redirect(to: dividend_declaration_path(conn, :index))
  end
end
