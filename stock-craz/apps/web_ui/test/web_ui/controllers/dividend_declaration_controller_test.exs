defmodule WebUi.DividendDeclarationControllerTest do
  use WebUi.ConnCase

  alias StockCraz.Securities

  @symbol "TICC"
  @create_attrs %{amount: "120.5", dec_date: "2010-04-17 14:00:00.000000Z", ex_date: "2010-04-17 14:00:00.000000Z", pay_date: "2010-04-17 14:00:00.000000Z", rec_date: "2010-04-17 14:00:00.000000Z", stock_id: 42}
  @update_attrs %{amount: "456.7", dec_date: "2011-05-18 15:01:01.000000Z", ex_date: "2011-05-18 15:01:01.000000Z", pay_date: "2011-05-18 15:01:01.000000Z", rec_date: "2011-05-18 15:01:01.000000Z", stock_id: 43}
  @invalid_attrs %{amount: nil, dec_date: nil, ex_date: nil, pay_date: nil, rec_date: nil, stock_id: nil}

  def fixture(:dividend_declaration) do
    {:ok, dividend_declaration} = Securities.create_dividend_declaration(@create_attrs, @symbol)
    dividend_declaration
  end

  describe "index" do
    setup [:create_dividend_declaration]

    test "lists all dividend_declarations", %{conn: conn} do
      conn = get conn, stock_dividend_declaration_path(conn, :index, @symbol)
      assert html_response(conn, 200) =~ "Listing Dividend declarations"
    end
  end

  describe "new dividend_declaration" do
    test "renders form", %{conn: conn} do
      conn = get conn, stock_dividend_declaration_path(conn, :new, @symbol)
      assert html_response(conn, 200) =~ "New Dividend declaration"
    end
  end

  describe "create dividend_declaration" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, stock_dividend_declaration_path(conn, :create, @symbol), dividend_declaration: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == stock_dividend_declaration_path(conn, :show, @symbol, id)

      conn = get conn, stock_dividend_declaration_path(conn, :show, @symbol, id)
      assert html_response(conn, 200) =~ "Show Dividend declaration"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, stock_dividend_declaration_path(conn, :create, @symbol), dividend_declaration: @invalid_attrs
      assert html_response(conn, 200) =~ "New Dividend declaration"
    end
  end

  describe "edit dividend_declaration" do
    setup [:create_dividend_declaration]

    test "renders form for editing chosen dividend_declaration", %{conn: conn, dividend_declaration: dividend_declaration} do
      conn = get conn, stock_dividend_declaration_path(conn, :edit, @symbol, dividend_declaration)
      assert html_response(conn, 200) =~ "Edit Dividend declaration"
    end
  end

  describe "update dividend_declaration" do
    setup [:create_dividend_declaration]

    test "redirects when data is valid", %{conn: conn, dividend_declaration: dividend_declaration} do
      conn = put conn, stock_dividend_declaration_path(conn, :update, @symbol, dividend_declaration.id), dividend_declaration: @update_attrs
      assert redirected_to(conn) == stock_dividend_declaration_path(conn, :show, @symbol, dividend_declaration.id)

      conn = get conn, stock_dividend_declaration_path(conn, :show, @symbol, dividend_declaration.id)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, dividend_declaration: dividend_declaration} do
      conn = put conn, stock_dividend_declaration_path(conn, :update, @symbol, dividend_declaration.id), dividend_declaration: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Dividend declaration"
    end
  end

  describe "delete dividend_declaration" do
    setup [:create_dividend_declaration]

    test "deletes chosen dividend_declaration", %{conn: conn, dividend_declaration: dividend_declaration} do
      conn = delete conn, stock_dividend_declaration_path(conn, :delete, @symbol, dividend_declaration)
      assert redirected_to(conn) == stock_dividend_declaration_path(conn, :index, @symbol)
      assert_error_sent 404, fn ->
        get conn, stock_dividend_declaration_path(conn, :show, @symbol, dividend_declaration)
      end
    end
  end

  defp create_dividend_declaration(_) do
    dividend_declaration = fixture(:dividend_declaration)
    {:ok, dividend_declaration: dividend_declaration}
  end
end
