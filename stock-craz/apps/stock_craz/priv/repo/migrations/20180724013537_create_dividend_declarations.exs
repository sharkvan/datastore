defmodule StockCraz.Repo.Migrations.CreateDividendDeclarations do
  use Ecto.Migration

  def change do
    create table(:dividend_declarations) do
      add :stock_id, :integer
      add :pay_date, :utc_datetime
      add :ex_date, :utc_datetime
      add :rec_date, :utc_datetime
      add :dec_date, :utc_datetime
      add :amount, :decimal

      timestamps()
    end

  end
end
