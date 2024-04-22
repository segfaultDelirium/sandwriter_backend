defmodule SandwriterBackend.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :text
      add :deleted_at, :naive_datetime
      add :author_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :replies_to, references(:comments, on_delete: :nothing, type: :binary_id)
      add :article_id, references(:articles, on_delete: :nothing, type: :binary_id)
      timestamps()
    end

    create index(:comments, [:author_id])
    create index(:comments, [:replies_to])
  end
end
