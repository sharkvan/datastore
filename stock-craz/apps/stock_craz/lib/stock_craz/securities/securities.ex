defmodule StockCraz.Securities do
  @moduledoc """
  The Stocks context.
  """

  import Ecto.Query, warn: false
  alias StockCraz.Repo
  alias StockCraz.Securities.Stock

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
  def get_stock(symbol) do
    query = from sec in Stock,
      where: sec.symbol == ^symbol

    Repo.one(query)
  end

  def get_stock!(symbol) do 
    query = from sec in Stock,
      where: sec.symbol == ^symbol

    Repo.one!(query)
  end

  def get_stock_by_id(id) do
    Repo.get(Stock, id)
  end

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

  alias StockCraz.Securities.DividendDeclaration

  @doc """
  Returns the list of dividend_declarations.

  ## Examples

      iex> list_dividend_declarations()
      [%DividendDeclaration{}, ...]

  """
  def list_dividend_declarations do
    Repo.all(DividendDeclaration)
  end

  @doc """
  Gets a single dividend_declaration.

  Raises `Ecto.NoResultsError` if the Dividend declaration does not exist.

  ## Examples

      iex> get_dividend_declaration!(123)
      %DividendDeclaration{}

      iex> get_dividend_declaration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dividend_declaration!(id), do: Repo.get!(DividendDeclaration, id)

  @doc """
  Creates a dividend_declaration.

  ## Examples

      iex> create_dividend_declaration(%{field: value})
      {:ok, %DividendDeclaration{}}

      iex> create_dividend_declaration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dividend_declaration(attrs \\ %{}) do
    %DividendDeclaration{}
    |> DividendDeclaration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dividend_declaration.

  ## Examples

      iex> update_dividend_declaration(dividend_declaration, %{field: new_value})
      {:ok, %DividendDeclaration{}}

      iex> update_dividend_declaration(dividend_declaration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dividend_declaration(%DividendDeclaration{} = dividend_declaration, attrs) do
    dividend_declaration
    |> DividendDeclaration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DividendDeclaration.

  ## Examples

      iex> delete_dividend_declaration(dividend_declaration)
      {:ok, %DividendDeclaration{}}

      iex> delete_dividend_declaration(dividend_declaration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dividend_declaration(%DividendDeclaration{} = dividend_declaration) do
    Repo.delete(dividend_declaration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dividend_declaration changes.

  ## Examples

      iex> change_dividend_declaration(dividend_declaration)
      %Ecto.Changeset{source: %DividendDeclaration{}}

  """
  def change_dividend_declaration(%DividendDeclaration{} = dividend_declaration) do
    DividendDeclaration.changeset(dividend_declaration, %{})
  end
end
