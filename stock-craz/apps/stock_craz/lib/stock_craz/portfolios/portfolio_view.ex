defmodule PortfolioView do
  use Ecto.Schema

  schema "portfolio_view" do
    field :portfolio_id, :integer
    field :starting_capital, :decimal
    field :starting_shares, :decimal
    field :current_value, :decimal
    field :current_allocation, :decimal
    field :current_shares, :decimal
    field :current_quarter_roi, :decimal
    field :cash, :decimal
    field :roi, :decimal
    field :yield, :decimal
    field :projected_yield, :decimal
    field :projected_dividend, :decimal
    field :first_month_payors, :decimal
    field :second_month_payors, :decimal
    field :third_month_payors, :decimal
    field :monthly_payors, :decimal
    field :last_dividend_date, :utc_datetime
    field :next_dividend_date, :utc_datetime
    field :avg_dividend, :decimal
    field :avg_investment_yield, :decimal
    field :avg_dividend_yield, :decimal
    field :potential_dividend, :decimal

  end

end
