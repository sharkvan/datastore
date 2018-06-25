defmodule StockCraz.Portfolios.Portfolio do
  use Ecto.Schema
  import Ecto.Changeset


  schema "portfolios" do
    field :name, :string
    field :user_id, :integer
    
    timestamps()
  end

  @doc false
  def changeset(portfolio, attrs) do
    portfolio
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
