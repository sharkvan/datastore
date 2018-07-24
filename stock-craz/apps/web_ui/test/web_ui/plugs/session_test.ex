defmodule WebUi.Plugs.SessionTest do 
  use WebUi.ConnCase

  alias StockCraz.Accounts
  alias WebUi.Plugs.Session

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(%{email: "test.me@stockcraz.com"})
    user
  end

  describe "Sign out" do
    test "session cleared", %{conn: conn} do
      user = fixture(:user)
      conn = Plug.Conn.put_session(conn, :current_user_id, user.id)
      Session.sign_out(conn)
      assert Plug.Conn.get_session(conn, :current_user_id) == nil
    end 
  end 
end 
