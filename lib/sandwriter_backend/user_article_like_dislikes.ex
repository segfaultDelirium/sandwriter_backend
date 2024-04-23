defmodule SandwriterBackend.UserArticleLikeDislikes do
  @moduledoc """
  The UserArticleLikeDislikes context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo

  alias SandwriterBackend.UserArticleLikeDislikes.UserArticleLikeDislike

  def get_by_article_id_and_user_id(article_id, account_id) do
    query =
      from user_article in UserArticleLikeDislike,
        where: user_article.article_id == ^article_id and user_article.account_id == ^account_id

    Repo.one(query)
  end

  def get_likes_count_by_article_id(article_id) do
    query =
      from user_article in UserArticleLikeDislike,
        where: user_article.article_id == ^article_id and user_article.is_liked == true,
        group_by: user_article.article_id,
        select: count(user_article.is_liked)

    case Repo.one(query) do
      nil -> 0
      x -> x
    end
  end

  def get_dislikes_count_by_article_id(article_id) do
    query =
      from user_article in UserArticleLikeDislike,
        where: user_article.article_id == ^article_id and user_article.is_disliked == true,
        group_by: user_article.article_id,
        select: count(user_article.is_disliked)

    case Repo.one(query) do
      nil -> 0
      x -> x
    end
  end

  @doc """
  Returns the list of user_article_like_dislikes.

  ## Examples

      iex> list_user_article_like_dislikes()
      [%UserArticleLikeDislike{}, ...]

  """
  def list_user_article_like_dislikes do
    Repo.all(UserArticleLikeDislike)
  end

  @doc """
  Gets a single user_article_like_dislike.

  Raises `Ecto.NoResultsError` if the User article like dislike does not exist.

  ## Examples

      iex> get_user_article_like_dislike!(123)
      %UserArticleLikeDislike{}

      iex> get_user_article_like_dislike!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_article_like_dislike!(id), do: Repo.get!(UserArticleLikeDislike, id)

  @doc """
  Creates a user_article_like_dislike.

  ## Examples

      iex> create_user_article_like_dislike(%{field: value})
      {:ok, %UserArticleLikeDislike{}}

      iex> create_user_article_like_dislike(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_article_like_dislike(attrs \\ %{}) do
    %UserArticleLikeDislike{}
    |> UserArticleLikeDislike.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_article_like_dislike.

  ## Examples

      iex> update_user_article_like_dislike(user_article_like_dislike, %{field: new_value})
      {:ok, %UserArticleLikeDislike{}}

      iex> update_user_article_like_dislike(user_article_like_dislike, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_article_like_dislike(
        %UserArticleLikeDislike{} = user_article_like_dislike,
        attrs
      ) do
    user_article_like_dislike
    |> UserArticleLikeDislike.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_article_like_dislike.

  ## Examples

      iex> delete_user_article_like_dislike(user_article_like_dislike)
      {:ok, %UserArticleLikeDislike{}}

      iex> delete_user_article_like_dislike(user_article_like_dislike)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_article_like_dislike(%UserArticleLikeDislike{} = user_article_like_dislike) do
    Repo.delete(user_article_like_dislike)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_article_like_dislike changes.

  ## Examples

      iex> change_user_article_like_dislike(user_article_like_dislike)
      %Ecto.Changeset{data: %UserArticleLikeDislike{}}

  """
  def change_user_article_like_dislike(
        %UserArticleLikeDislike{} = user_article_like_dislike,
        attrs \\ %{}
      ) do
    UserArticleLikeDislike.changeset(user_article_like_dislike, attrs)
  end
end
