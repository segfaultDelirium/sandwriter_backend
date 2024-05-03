defmodule SandwriterBackend.UserArticleLikeDislikes.UserArticleLikeDislike do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_article_like_dislikes" do
    field :is_liked, :boolean, default: false
    field :is_disliked, :boolean, default: false
    field :account_id, :binary_id
    field :article_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user_article_like_dislike, attrs) do
    user_article_like_dislike
    |> cast(attrs, [:account_id, :article_id, :is_liked, :is_disliked])
    |> validate_required([:account_id, :article_id, :is_liked, :is_disliked])
  end

  def get_viewable_fields() do
    [:id, :account_id, :article_id, :is_liked, :is_disliked] ++
      Helpers.timestamp_fields_without_deleted()
  end
end
