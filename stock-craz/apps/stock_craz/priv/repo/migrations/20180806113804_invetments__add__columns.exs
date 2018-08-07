defmodule StockCraz.Repo.Migrations.Invetments_Add_Columns do
  use Ecto.Migration

  def change do
    alter table(:investments) do
      add :current_allocation, :decimal
      add :yield, :decimal
      add :purchase_price, :decimal
      add :current_value, :decimal
      add :projected_dividend, :decimal
      add :potential_dividend, :decimal
      add :target_sell_price, :decimal
      add :target_sell_shares, :decimal
      add :current_roi, :decimal
    end
  end
end
