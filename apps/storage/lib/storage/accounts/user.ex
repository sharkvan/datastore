defmodule Storage.Accounts.User do
    use Ecto.Schema

    import Ecto.Changeset

    schema "users" do
        field(:email, :string)
        field(:confirmed, :boolean, default: false)

        timestamps
    end

    @required_fields ~w(email)a
    @optional_fields ~w()a

    def changeset(user, params \\ %{}) do
        user
        |> cast(params, @required_fields, @optional_fields)
        |> validate_required(@required_fields)
        |> unique_constraint(:email)
    end
end
