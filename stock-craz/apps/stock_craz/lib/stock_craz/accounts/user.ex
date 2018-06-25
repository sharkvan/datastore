defmodule StockCraz.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/, [message: "The email address does not appear to be valid. Pleae check the format"])
  end
end
