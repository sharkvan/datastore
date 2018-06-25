defmodule StockCraz.Repo.Migrations.CreateInvestments do
  use Ecto.Migration

  def change do
    create table(:investments) do
      add :stock_id, :integer
      add :portfolio_id, :integer
      add :cost_basis, :decimal
      add :investment_date, :utc_datetime
      add :starting_shares, :integer
      add :shares, :decimal
      add :target_roi, :decimal

      timestamps()
    end

  end
end
