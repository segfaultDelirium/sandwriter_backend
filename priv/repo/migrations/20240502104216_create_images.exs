defmodule SandwriterBackend.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :data, :binary
      add :deleted_at, :naive_datetime
      add :uploaded_by, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:images, [:uploaded_by])
  end
end
