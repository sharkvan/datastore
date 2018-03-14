defmodule Storage.Accounts.User do
    use Ecto.Schema

    import Ecto.Changeset

    schema "users" do
        field(:email, :string)
        field(:confirmed, :boolean, default: false)

        timestamps
    end

    @required_fields ~w(email)
    @optional_fields ~w()

    def changeset(user, params \\ :empty) do
        user
        |> cast(params, @required_fields, @optional_fields)
        |> unique_constraint(:email)
    end
end
