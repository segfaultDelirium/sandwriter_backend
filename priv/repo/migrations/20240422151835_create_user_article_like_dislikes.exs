defmodule SandwriterBackend.Repo.Migrations.CreateUserArticleLikeDislikes do
  use Ecto.Migration

  def change do
    create table(:user_article_like_dislikes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :is_liked, :boolean, default: false, null: false
      add :is_disliked, :boolean, default: false, null: false
      add :user_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :article_id, references(:articles, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:user_article_like_dislikes, [:user_id, :article_id])
    # create index(:user_article_like_dislikes, [:article_id])
  end
end
