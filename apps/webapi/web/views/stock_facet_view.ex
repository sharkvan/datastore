defmodule Webapi.StockFacetView do
  use Webapi.Web, :view

  def render("index.json", %{stockfacets: stockfacets}) do
    %{data: render_many(stockfacets, Webapi.StockFacetView, "stock_facet.json")}
  end

  def render("show.json", %{stock_facet: stock_facet}) do
    render_one(stock_facet, Webapi.StockFacetView, "stock_facet.json")
  end

  def render("stock_facet.json", %{stock_facet: stock_facet}) do
      stock_facet
  end
end
