defmodule StockCraz.Portfolios.InvestmentViewModel do
  use Ecto.Schema
  import Ecto.Changeset

  alias StockCraz.Securities.Stock
  alias StockCraz.Securities.DividendDeclaration
  alias StockCraz.Portfolios.Investment

  schema "investment_view_model" do
    field :portfolio_id, :integer
    field :symbol, :string
    field :current_allocation, :decimal
    field :yield, :decimal
    field :dividend_yield, :decimal
    field :dividend_frequency, :decimal
    field :dividend_pay_qtr_month, :integer
    field :investment_date, :utc_datetime
    field :investment_qtr, :string
    field :sector, :string
    field :industry, :string
    field :starting_shares, :integer
    field :purchase_price, :decimal
    field :cost_basis, :decimal
    field :current_shares, :decimal
    field :current_price, :decimal
    field :current_value, :decimal
    field :ex_date, :utc_datetime
    field :pay_date, :utc_datetime
    field :dividend_amount, :utc_datetime
    field :projected_dividend, :decimal
    field :potential_dividend, :decimal
    field :target_roi, :decimal
    field :target_sell_price, :decimal
    field :target_sell_shares, :decimal
    field :current_roi, :decimal
  end

  def load(investment, %Stock{} = values) do
    %{investment | symbol: values.symbol, 
      current_price: values.price}
  end

  def load(investment, %DividendDeclaration{} = values) do
    %{investment | dividend_amount: values.amount }
  end

  def load(investment, %Investment{} = values) do
    %{investment | id: values.id,
      current_shares: values.shares,
      portfolio_id: values.portfolio_id,
      investment_date: values.investment_date,
      projected_dividend: values.projected_dividend,
      potential_dividend: values.potential_dividend,
      cost_basis: values.cost_basis,
      investment_qtr: values.investment_qtr,
      starting_shares: values.starting_shares,
      target_roi: values.target_roi,
      purchase_price: values.purchase_price,
      target_sell_price: values.target_sell_price,
      target_sell_shares: values.target_sell_shares,
      current_roi: values.current_roi,
      yield: values.yield,
      
    }
  end

  def load(investment, values) do
    investment
  end
end

