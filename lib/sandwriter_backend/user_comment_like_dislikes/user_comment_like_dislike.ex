defmodule SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_comment_like_dislikes" do
    field :is_liked, :boolean, default: false
    field :is_disliked, :boolean, default: false
    field :account_id, :binary_id
    field :comment_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user_comment_like_dislike, attrs) do
    user_comment_like_dislike
    |> cast(attrs, [:is_liked, :is_disliked])
    |> validate_required([:is_liked, :is_disliked])
  end
end
