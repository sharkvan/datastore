defmodule StockCraz.Portfolios do
  @moduledoc """
  The Portfolios context.
  """

  import Ecto.Query, warn: false
  alias StockCraz.Repo

  alias StockCraz.Portfolios.Portfolio

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

  alias StockCraz.Portfolios.Investment

  @doc """
  Returns the list of investments.

  ## Examples

      iex> list_investments()
      [%Investment{}, ...]

  """
  def list_investments do
    Repo.all(Investment)
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
  def get_investment!(id), do: Repo.get!(Investment, id)

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
end
