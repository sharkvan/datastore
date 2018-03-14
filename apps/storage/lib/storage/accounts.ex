defmodule Storage.Accounts do
    import Ecto.Query

    alias Storage.Accounts.{User}
    alias Storage.Repo
    
    def add_user(user) do
        User.changeset(%User{}, user)
        |> Repo.insert()
    end

    def get_user(email) do
        query =
          from(
            u in User,
            where: u.email == ^email,
            select: u
          )

        Repo.all(query)
    end
end
