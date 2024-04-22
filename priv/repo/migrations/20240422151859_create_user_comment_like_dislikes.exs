defmodule SandwriterBackend.Repo.Migrations.CreateUserCommentLikeDislikes do
  use Ecto.Migration

  def change do
    create table(:user_comment_like_dislikes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :is_liked, :boolean, default: false, null: false
      add :is_disliked, :boolean, default: false, null: false
      add :user_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :comment_id, references(:comments, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:user_comment_like_dislikes, [:user_id, :comment_id])
    # create index(:user_comment_like_dislikes, [:comment_id])
  end
end
