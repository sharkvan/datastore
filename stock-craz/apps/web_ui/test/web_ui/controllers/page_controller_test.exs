defmodule WebUi.PageControllerTest do
  use WebUi.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to StockCraz!"
  end
end
