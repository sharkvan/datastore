defmodule Storage.Accounts.UserTests do
    use ExUnit.Case

    alias Storage.Accounts.User

    doctest User

    test "Validate required fields" do
        changeset = User.changeset(%User{}, %{})
        
        assert changeset.valid? == false       
        assert changeset.errors == [email: {"can't be blank", [validation: :required]}]

    end

    test "Validate optional params" do
        changeset = User.changeset(%User{})

        assert changeset.valid? == false
        assert changeset.errors == [email: {"can't be blank", [validation: :required]}]
    end
end
