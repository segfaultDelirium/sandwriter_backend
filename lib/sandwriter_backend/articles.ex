defmodule SandwriterBackend.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.{Repo, Accounts.Account, Users.User}

  alias SandwriterBackend.Articles.Article

  # query =
  #   from user_article in UserArticleLikeDislike,
  #     where: user_article.article_id == ^article_id and user_article.is_liked == true,
  #     group_by: user_article.article_id,
  #     select: count(user_article.is_liked)

  def get_all_without_text_and_comments() do
    query =
      from article in Article,
        join: account in Account,
        on: article.author_id == account.id,
        join: user in User,
        on: account.id == user.account_id,
        select: %{
          id: article.id,
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
          },
          title: article.title,
          slug: article.slug,
          inserted_at: article.inserted_at,
          updated_at: article.updated_at,
          deleted_at: article.deleted_at
        }

    Repo.all(query)
  end

  def get_by_slug(slug) do
    Repo.get_by(Article, slug: slug)
  end

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
