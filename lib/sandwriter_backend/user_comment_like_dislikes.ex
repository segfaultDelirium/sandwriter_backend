defmodule SandwriterBackend.UserCommentLikeDislikes do
  @moduledoc """
  The UserCommentLikeDislikes context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo

  alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike

  def get_by_comment_id_and_account_id(comment_id, account_id) do
    query =
      from user_comment in UserCommentLikeDislike,
        where: user_comment.comment_id == ^comment_id and user_comment.account_id == ^account_id

    Repo.one(query)
  end

  @doc """
  Returns the list of user_comment_like_dislikes.

  ## Examples

      iex> list_user_comment_like_dislikes()
      [%UserCommentLikeDislike{}, ...]

  """
  def list_user_comment_like_dislikes do
    Repo.all(UserCommentLikeDislike)
  end

  @doc """
  Gets a single user_comment_like_dislike.

  Raises `Ecto.NoResultsError` if the User comment like dislike does not exist.

  ## Examples

      iex> get_user_comment_like_dislike!(123)
      %UserCommentLikeDislike{}

      iex> get_user_comment_like_dislike!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_comment_like_dislike!(id), do: Repo.get!(UserCommentLikeDislike, id)

  @doc """
  Creates a user_comment_like_dislike.

  ## Examples

      iex> create_user_comment_like_dislike(%{field: value})
      {:ok, %UserCommentLikeDislike{}}

      iex> create_user_comment_like_dislike(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_comment_like_dislike(attrs \\ %{}) do
    %UserCommentLikeDislike{}
    |> UserCommentLikeDislike.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_comment_like_dislike.

  ## Examples

      iex> update_user_comment_like_dislike(user_comment_like_dislike, %{field: new_value})
      {:ok, %UserCommentLikeDislike{}}

      iex> update_user_comment_like_dislike(user_comment_like_dislike, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_comment_like_dislike(
        %UserCommentLikeDislike{} = user_comment_like_dislike,
        attrs
      ) do
    user_comment_like_dislike
    |> UserCommentLikeDislike.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_comment_like_dislike.

  ## Examples

      iex> delete_user_comment_like_dislike(user_comment_like_dislike)
      {:ok, %UserCommentLikeDislike{}}

      iex> delete_user_comment_like_dislike(user_comment_like_dislike)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_comment_like_dislike(%UserCommentLikeDislike{} = user_comment_like_dislike) do
    Repo.delete(user_comment_like_dislike)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_comment_like_dislike changes.

  ## Examples

      iex> change_user_comment_like_dislike(user_comment_like_dislike)
      %Ecto.Changeset{data: %UserCommentLikeDislike{}}

  """
  def change_user_comment_like_dislike(
        %UserCommentLikeDislike{} = user_comment_like_dislike,
        attrs \\ %{}
      ) do
    UserCommentLikeDislike.changeset(user_comment_like_dislike, attrs)
  end
end
