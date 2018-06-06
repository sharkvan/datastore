defmodule StockCraz.Security.Stocks do
  @moduledoc """
  The Stocks context.
  """

  import Ecto.Query, warn: false
  alias StockCraz.Repo
  alias StockCraz.Security.Stock

  @doc """
  Returns all the stocks in the systems

  ## Examples

    iex> list_stocks()
    [%Stock{}, ...]

  """
  def list_stocks do
    Repo.all(Stock)
  end

  @doc """
  Gets a single stock.
  
  ## Examples

    iex> get_stock("OXLC")
    %Stock{}
  
  """
  def get_stock(symbol), do: Repo.get(Stock, symbol)

  def get_stock!(symbol), do: Repo.get!(Stock, symbol)

  @doc """
  Create a stock record
  
  #Examples

    iex> create_stock(%{symbol:"OXLC"})
    {ok: %Stock{}}
    
    iex> create_stock(%{ysmbol: ""})
    {:error, %Ecto.Changeset{}}
    
  """
  def create_stock(attrs \\ %{}) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

    iex> update_stock(stock, %{price: 11.56})
    {:ok, %Stock{}}

    iex> update_stock(stock, %{price: ""})
    {:error, %Ecto.Changeset{}}
  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  def change_stock(%Stock{} = stock) do
    Stock.changeset(stock, %{})
  end
end

