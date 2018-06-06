defmodule Stockcraz.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks, primary_key: false) do
      add :symbol, :string, primary_key: true
      add :name, :string
      add :price, :decimal
      add :eps, :decimal
      add :price_high_year, :decimal
      add :price_low_year, :decimal

      timestamps()
    end
  end
end
