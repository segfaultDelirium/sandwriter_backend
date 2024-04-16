defmodule SandwriterBackend.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :login, :string
      add :hashed_password, :string
      add :deleted_at, :naive_datetime

      timestamps()
    end

    create unique_index(:accounts, [:login])
  end
end
