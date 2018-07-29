defmodule WebUi.DividendDeclarationController do
  use WebUi, :controller

  alias StockCraz.Securities
  alias StockCraz.Securities.DividendDeclaration

  defp to_dividend_declaration(params) do
    struct_from_map(params, as: %DividendDeclaration{})
  end

  def struct_from_map(a_map, as: a_struct) do
    # Find the keys within the map
    keys = Map.keys(a_struct)
           |> Enum.filter(fn x -> x != :__struct__ end)
    # Process map, checking for both string / atom keys
    processed_map = 
      for key <- keys, into: %{} do
        value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
        {key, value}
      end
    Map.merge(a_struct, processed_map)
  end

  def index(conn, %{"stock_symbol" => symbol}) do
    dividend_declarations = Securities.list_dividend_declarations(symbol)
    render(conn, "index.html", dividend_declarations: dividend_declarations, symbol: symbol)
  end

  def new(conn, %{"stock_symbol" => symbol}) do
    changeset = Securities.change_dividend_declaration(%DividendDeclaration{})
    render(conn, "new.html", changeset: changeset, symbol: symbol)
  end

  def create(conn, %{"stock_symbol" => symbol, "dividend_declaration" => dividend_declaration_params}) do
    dividend_declaration_params
    |> to_dividend_declaration
    |> Map.from_struct
    |> Securities.create_dividend_declaration(symbol)
    |> case do
      {:ok, dividend_declaration} ->
        conn
        |> put_flash(:info, "Dividend declaration created successfully.")
        |> redirect(to: stock_dividend_declaration_path(conn, :show, symbol, dividend_declaration))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, symbol: symbol)
    end
  end

  def show(conn, %{"id" => id, "stock_symbol" => symbol}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)
    render(conn, "show.html", dividend_declaration: dividend_declaration, symbol: symbol)
  end

  def edit(conn, %{"id" => id, "stock_symbol" => symbol}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)
    changeset = Securities.change_dividend_declaration(dividend_declaration)
    render(conn, "edit.html", symbol: symbol, dividend_declaration: dividend_declaration, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_symbol" => symbol, "dividend_declaration" => attrs}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)

    dividend_declaration_params = attrs
    |> to_dividend_declaration
    |> Map.from_struct

    case Securities.update_dividend_declaration(dividend_declaration, dividend_declaration_params, symbol) do
      {:ok, dividend_declaration} ->
        conn
        |> put_flash(:info, "Dividend declaration updated successfully.")
        |> redirect(to: stock_dividend_declaration_path(conn, :show, symbol, dividend_declaration.id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", dividend_declaration: dividend_declaration, changeset: changeset, symbol: symbol )
    end
  end

  def delete(conn, %{"id" => id, "stock_symbol" => symbol}) do
    dividend_declaration = Securities.get_dividend_declaration!(id)
    {:ok, _dividend_declaration} = Securities.delete_dividend_declaration(dividend_declaration)

    conn
    |> put_flash(:info, "Dividend declaration deleted successfully.")
    |> redirect(to: stock_dividend_declaration_path(conn, :index, symbol))
  end
end
