defmodule Webapi.Router do
  use Webapi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    get "securities.csv", Webapi.StockControllerCSV, :csv
    resources "/", Webapi.StockController, only: [:show, :create, :update], param: "symbol" do
        resources "/", Webapi.StockFacetController, only: [:show, :create, :update], param: "facet", as: "facet" do
            resources "/history", Webapi.StockFacetHistoryController, only: [:index], as: "history"
        end
    end

  end
end
