defmodule WebUi.PageController do
  use WebUi, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
