defmodule SandwriterBackend.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  import MapMerge
  alias SandwriterBackend.Repo

  alias SandwriterBackend.Comments.Comment
  alias SandwriterBackend.Accounts.Account
  alias SandwriterBackend.Users.User
  alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike

  def get_comment_count_per_article_id() do
    query =
      from comment in Comment,
        group_by: comment.article_id,
        select: %{count: count(comment.id), article_id: comment.article_id}

    Repo.all(query)
  end

  def get_by_article_id(article_id) do
    query =
      from comment in Comment,
        join: account in Account,
        on: account.id == comment.author_id,
        join: user in User,
        on: user.account_id == account.id,
        where: comment.article_id == ^article_id,
        select: %{
          id: comment.id,
          text: comment.text,
          author_id: comment.author_id,
          article_id: comment.article_id,
          replies_to: comment.replies_to,
          inserted_at: comment.inserted_at,
          updated_at: comment.updated_at,
          deleted_at: comment.deleted_at,
          author: %{
            id: user.id,
            email: user.email,
            display_name: user.display_name,
            full_name: user.full_name,
            gender: user.gender,
            biography: user.biography,
            phone_number: user.phone_number,
            inserted_at: user.inserted_at,
            updated_at: user.updated_at,
            deleted_at: user.deleted_at
          }
        }

    Repo.all(query)
  end

  def get_like_dislike_count_per_comment_in_article(article_id, account_id) do
    query =
      from comment in Comment,
        join: user_comment_like_dislike in UserCommentLikeDislike,
        on: user_comment_like_dislike.comment_id == comment.id,
        where: comment.article_id == ^article_id,
        group_by: user_comment_like_dislike.comment_id,
        select: %{
          comment_id: user_comment_like_dislike.comment_id,
          is_liked_by_current_user:
            count(
              fragment(
                "CASE WHEN ? THEN 1 ELSE NULL END",
                user_comment_like_dislike.account_id == ^account_id and
                  user_comment_like_dislike.is_liked
              )
            ),
          is_disliked_by_current_user:
            count(
              fragment(
                "CASE WHEN ? THEN 1 ELSE NULL END",
                user_comment_like_dislike.account_id == ^account_id and
                  user_comment_like_dislike.is_disliked
              )
            ),
          likes_count:
            count(
              fragment("CASE WHEN ? THEN 1 ELSE NULL END", user_comment_like_dislike.is_liked)
            ),
          dislikes_count:
            count(
              fragment("CASE WHEN ? THEN 1 ELSE NULL END", user_comment_like_dislike.is_disliked)
            )
        }

    Repo.all(query)
  end

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end
end
