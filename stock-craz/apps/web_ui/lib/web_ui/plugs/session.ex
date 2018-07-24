defmodule WebUi.Plugs.Session do
  import Plug.Conn

  alias StockCraz.Accounts
  alias StockCraz.Accounts.User

  def init(_params) do
  end

  def call(conn, _opts) do
    user = current_user(conn)
    cond do
      user ->
        conn
        |> assign(:user_signed_in?, true)
        |> assign(:current_user, user)
      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end

  def current_user_id(conn) do
    get_session(conn, :current_user_id)
  end

  def current_user(conn) do
    get_session(conn, :current_user)
  end

  def signed_in(conn) do
    if conn.assigns.user_signed_in? do
      {:ok, current_user(conn)}
    else
      {:error, nil}
    end
  end

  def sign_in(conn, user) do
    conn
      |> put_session(:current_user, user)
      |> put_session(:current_user_id, user.id)
  end

  def sign_out(conn) do
    conn
      |> configure_session(drop: true)
  end
end
