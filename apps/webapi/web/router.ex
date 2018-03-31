defmodule Webapi.Router do
  use Webapi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    resources "/users", Webapi.UserController

    get "securities.csv", Webapi.StockControllerCSV, :csv

    get "/", Webapi.HomeController, :index
  end

  scope "/api" do
    pipe_through :api
  
    resources "/", Webapi.StockController, only: [:show, :create, :update], param: "symbol" do
        resources "/", Webapi.StockFacetController, only: [:show, :create, :update], param: "facet", as: "facet" do
            resources "/history", Webapi.StockFacetHistoryController, only: [:index], as: "history"
        end
    end

  end
end
