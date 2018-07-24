defmodule WebUi.SessionController do
  use WebUi, :controller

  alias StockCraz.Accounts
  alias WebUi.Plugs.Session

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email}}) do
    case Accounts.get_user_by_email(email) do
      {:ok, user} ->
        conn
        |> WebUi.Plugs.Session.sign_in(user)
        |> put_flash(:info, "You have successfully signed in!")
        |> redirect(to: page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> WebUi.Plugs.Session.sign_out()
        |> put_flash(:error, "Invalid Email")
        |> render("new.html")
    end
  end

  def signout(conn, _params) do
    conn
    |> Session.sign_out()
    |> redirect(to: page_path(conn, :index))
  end
end
