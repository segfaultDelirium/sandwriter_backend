defmodule SandwriterBackend.Repo.Migrations.CreateImageArticles do
  use Ecto.Migration

  def change do
    create table(:image_articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :article_id, references(:articles, on_delete: :nothing, type: :binary_id)
      add :image_id, references(:images, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:image_articles, [:article_id, :image_id])
  end
end
