defmodule StockCraz.Portfolios.Investment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "investments" do
    field :symbol, :string, virtual: true
    field :portfolio_id, :integer
    field :current_allocation, :decimal
    field :yield, :decimal
    field :stock_id, :integer
    field :cost_basis, :decimal
    field :investment_date, :utc_datetime
    field :investment_qtr, :string
    field :shares, :decimal
    field :starting_shares, :integer
    field :target_roi, :decimal
    field :purchase_price, :decimal
    field :current_value, :decimal
    field :projected_dividend, :decimal
    field :potential_dividend, :decimal
    field :target_sell_price, :decimal
    field :target_sell_shares, :integer
    field :current_roi, :decimal

    timestamps()

  end

  @doc false
  def changeset(investment, attrs) do
    investment
    |> cast(attrs, [:portfolio_id, :stock_id, :cost_basis, :investment_date, :starting_shares, :shares, :target_roi])
    |> validate_required([:portfolio_id, :stock_id, :cost_basis, :investment_date, :starting_shares, :shares, :target_roi])
  end
end
