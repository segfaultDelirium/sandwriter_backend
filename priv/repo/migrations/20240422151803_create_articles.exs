defmodule SandwriterBackend.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :slug, :string
      # add :text, :text
      add :deleted_at, :naive_datetime
      add :author_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:articles, [:author_id])
    create unique_index(:articles, [:slug])
  end
end
