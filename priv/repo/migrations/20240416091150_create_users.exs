defmodule SandwriterBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :display_name, :string
      add :full_name, :string
      add :gender, :string
      add :biography, :text
      add :deleted_at, :naive_datetime
      add :phone_number, :string
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:users, [:account_id])
    create unique_index(:users, [:display_name])
  end
end
