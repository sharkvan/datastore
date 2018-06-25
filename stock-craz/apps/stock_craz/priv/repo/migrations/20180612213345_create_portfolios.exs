defmodule StockCraz.Repo.Migrations.CreatePortfolios do
  use Ecto.Migration

  def change do
    create table(:portfolios) do
      add :name, :string
      add :user_id, :integer

      timestamps()
    end

    create unique_index(:portfolios, [:name, :user_id])
  end
end
