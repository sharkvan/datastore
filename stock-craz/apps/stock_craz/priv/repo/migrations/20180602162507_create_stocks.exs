defmodule StockCraz.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :symbol, :string
      add :name, :string
      add :price, :decimal
      add :eps, :decimal
      add :price_high_year, :decimal
      add :price_low_year, :decimal

      timestamps()
    end

    create unique_index(:stocks, [:symbol])
  end
end
