defmodule Webapi.StockFacetController do
  use Webapi.Web, :controller

  alias Webapi.StockCache.Cache
  
  def show(conn, %{"stock_symbol" => symbol, "facet" => facet}) do
    case Cache.get(symbol) do
        {:not_found} ->
            send_resp(conn, :not_found, "")
        {:found, stock} ->
            value = Map.get(stock, facet)
            render(conn, "stock_facet.json",
                stock_facet: %{facet => value})
    end
  end

  def create(conn, %{"stock_symbol" => symbol, "facet" => facet}) do
    IO.inspect facet
    
    facet = case is_map(facet) do
        false -> Poison.decode!(facet)
        true -> facet
    end

    stock = case Cache.get(symbol) do
                {:found, value} -> value
                {:not_found, _} -> %{}
            end
            |> Map.merge(facet)

    Cache.set(symbol, stock)

    {facet_key, _} = Map.to_list(facet)
                     |> Enum.at(0)

    conn
    |> put_status(:created)
    |> put_resp_header("location", stock_facet_path(conn, :show, symbol, facet_key))
    |> render("show.json", stock_facet: stock)

  end

  def update(conn, %{"stock_symbol" => symbol, "facet" => facet, "value" => facet_value}) do
 
    update_value = fn _ -> String.to_float(facet_value) end
    stock = case Cache.get(symbol) do
                {:found, record} -> record
                {:not_found, _} -> %{}
            end
            |> IO.inspect
            |> Map.update(facet, facet_value, update_value)
            |> IO.inspect

    Cache.set(symbol, stock)

    conn
    |> put_status(:ok)
    |> put_resp_header("location", stock_facet_path(conn, :show, symbol, facet))
    |> render("show.json", stock_facet: stock)
  end

  def delete(conn, %{"id" => id}) do
    #stock_facet = Repo.get!(StockFacet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise an exception).
    #Repo.delete!(stock_facet)

    #send_resp(conn, :no_content, "")
  end
end
