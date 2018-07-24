defmodule StockCraz.Securities.DividendDeclaration do
  use Ecto.Schema
  import Ecto.Changeset


  schema "dividend_declarations" do
    field :amount, :decimal
    field :dec_date, :utc_datetime
    field :ex_date, :utc_datetime
    field :pay_date, :utc_datetime
    field :rec_date, :utc_datetime
    field :stock_id, :integer

    timestamps()
  end

  @doc false
  def changeset(dividend_declaration, attrs) do
    dividend_declaration
    |> cast(attrs, [:stock_id, :pay_date, :ex_date, :rec_date, :dec_date, :amount])
    |> validate_required([:stock_id, :pay_date, :ex_date, :rec_date, :dec_date, :amount])
  end
end
