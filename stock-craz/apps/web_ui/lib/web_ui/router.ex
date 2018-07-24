defmodule WebUi.Router do
  use WebUi, :router

  alias WebUi.Plugs.Session

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WebUi.Plugs.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug :fetch_session
  end

  scope "/", WebUi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create]

    get "/signout", SessionController, :signout
  end

  scope "/", WebUi do
    pipe_through [:browser, :authenticated]

    resources "/stocks", StockController, param: "symbol" do
      resources "/dividends", DividendDeclarationController
    end

    resources "/portfolios", PortfolioController do
      resources "/investments", InvestmentController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebUi do
  #   pipe_through :api
  # end
end
