defmodule StockCraz.Portfolios.Investment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "investments" do
    field :portfolio_id, :integer
    field :stock_id, :integer
    field :cost_basis, :decimal
    field :investment_date, :utc_datetime
    field :shares, :decimal
    field :starting_shares, :integer
    field :target_roi, :decimal

    timestamps()
  end

  @doc false
  def changeset(investment, attrs) do
    investment
    |> cast(attrs, [:portfolio_id, :stock_id, :cost_basis, :investment_date, :starting_shares, :shares, :target_roi])
    |> validate_required([:portfolio_id, :stock_id, :cost_basis, :investment_date, :starting_shares, :shares, :target_roi])
  end
end
