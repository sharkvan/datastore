defmodule StockCraz.Securities.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :symbol}
  schema "stocks" do
    field :symbol, :string
    field :eps, :decimal
    field :name, :string
    field :price, :decimal
    field :price_high_year, :decimal
    field :price_low_year, :decimal

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:symbol, :name, :price, :eps, :price_high_year, :price_low_year])
    |> validate_required([:symbol])
    |> validate_length(:symbol, min: 1)
    |> unique_constraint(:symbol)
  end
end
