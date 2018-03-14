defmodule Storage.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users) do
        add(:email, :string, unique: true)
        add(:confirmed, :boolean, default: false)
        timestamps()
    end

    create(unique_index(:users, [:email], name: :unique_emails))
  end
end
