defmodule StockCraz.Portfolios do
  @moduledoc """
  The Portfolios context.
  """

  import Ecto.Query, warn: false
  alias StockCraz.Repo
  alias StockCraz.Portfolios.Portfolio
  alias StockCraz.Portfolios.Investment
  alias StockCraz.Securities
  alias StockCraz.Securities.{Stock, DividendDeclaration}
  alias StockCraz.Portfolios.InvestmentViewModel

  @doc """
  Returns the list of portfolios.

  ## Examples

      iex> list_portfolios()
      [%Portfolio{}, ...]

  """
  def list_portfolios do
    Repo.all(Portfolio)
  end

  @doc """
  Gets a single portfolio.

  Raises `Ecto.NoResultsError` if the Portfolio does not exist.

  ## Examples

      iex> get_portfolio!(123)
      %Portfolio{}

      iex> get_portfolio!(456)
      ** (Ecto.NoResultsError)

  """
  def get_portfolio!(id), do: Repo.get!(Portfolio, id)

  @doc """
  Creates a portfolio.

  ## Examples

      iex> create_portfolio(%{field: value})
      {:ok, %Portfolio{}}

      iex> create_portfolio(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_portfolio(attrs \\ %{}) do
    %Portfolio{}
    |> Portfolio.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a portfolio.

  ## Examples

      iex> update_portfolio(portfolio, %{field: new_value})
      {:ok, %Portfolio{}}

      iex> update_portfolio(portfolio, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_portfolio(%Portfolio{} = portfolio, attrs) do
    portfolio
    |> Portfolio.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Portfolio.

  ## Examples

      iex> delete_portfolio(portfolio)
      {:ok, %Portfolio{}}

      iex> delete_portfolio(portfolio)
      {:error, %Ecto.Changeset{}}

  """
  def delete_portfolio(%Portfolio{} = portfolio) do
    Repo.delete(portfolio)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking portfolio changes.

  ## Examples

      iex> change_portfolio(portfolio)
      %Ecto.Changeset{source: %Portfolio{}}

  """
  def change_portfolio(%Portfolio{} = portfolio) do
    Portfolio.changeset(portfolio, %{})
  end


  @doc """
  Returns the list of investments for a portfolio.

  ## Examples

      iex> list_investments(1)
      [%Investment{}, ...]

  """
  def list_investments(portfolio_id) do
    get_investments(portfolio_id)
    |> Enum.map(&set_symbol/1)
  end

  defp get_investments(portfolio_id) do
    query = from i in Investment, where: i.portfolio_id == ^portfolio_id
    Repo.all(query)
  end

  @doc """
  Gets a single investment.

  Raises `Ecto.NoResultsError` if the Investment does not exist.

  ## Examples

      iex> get_investment!(123)
      %Investment{}

      iex> get_investment!(456)
      ** (Ecto.NoResultsError)

  """
  # Update the investment retrieval to have the stock symbol.
  # This may mean that we look up the symbol. We might even rethink
  # this current solution to use CQRS like commands and events.
  def get_investment!(id) do
    Repo.get!(Investment, id)
    |> set_symbol()
  end

  defp set_symbol(investment) do

    case Securities.get_stock_by_id(investment.stock_id) do
      nil ->
        investment
      stock ->
        investment
        |> Map.put(:symbol, stock.symbol)
    end
  end
    

  @doc """
  Creates a investment.

  ## Examples

      iex> create_investment(%{field: value})
      {:ok, %Investment{}}

      iex> create_investment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_investment(attrs \\ %{}) do
    %Investment{}
    |> Investment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a investment.

  ## Examples

      iex> update_investment(investment, %{field: new_value})
      {:ok, %Investment{}}

      iex> update_investment(investment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_investment(%Investment{} = investment, attrs) do
    investment
    |> Investment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Investment.

  ## Examples

      iex> delete_investment(investment)
      {:ok, %Investment{}}

      iex> delete_investment(investment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_investment(%Investment{} = investment) do
    Repo.delete(investment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking investment changes.

  ## Examples

      iex> change_investment(investment)
      %Ecto.Changeset{source: %Investment{}}

  """
  def change_investment(%Investment{} = investment) do
    Investment.changeset(investment, %{})
  end

  def list_investment_views(portfolio_id) do
    query = from i in Investment,
      join: s in Stock, on: i.stock_id == s.id,
      left_join: dd in DividendDeclaration, on: dd.stock_id == s.id,
      where: i.portfolio_id == ^portfolio_id,
      select: {i,s,dd}

    Repo.all(query)
    |> Stream.map( fn({investment, stock, div_dec}) ->
      InvestmentViewModel.load(%InvestmentViewModel{}, investment)
      |> InvestmentViewModel.load(stock)
      |> InvestmentViewModel.load(div_dec)
    end
    )
  end
end
