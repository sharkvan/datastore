defmodule StockCraz.Repo.Migrations.InvestmentAddInvestmentQtr do
  use Ecto.Migration

  def change do
    alter table(:investments) do
      add :investment_qtr, :string, size: 6
    end
  end
end
