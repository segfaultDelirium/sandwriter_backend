defmodule SandwriterBackend.ImageArticles do
  @moduledoc """
  The ImageArticles context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo

  alias SandwriterBackend.ImageArticles.ImageArticle

  @doc """
  Returns the list of image_articles.

  ## Examples

      iex> list_image_articles()
      [%ImageArticle{}, ...]

  """
  def list_image_articles do
    Repo.all(ImageArticle)
  end

  @doc """
  Gets a single image_article.

  Raises `Ecto.NoResultsError` if the Image article does not exist.

  ## Examples

      iex> get_image_article!(123)
      %ImageArticle{}

      iex> get_image_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image_article!(id), do: Repo.get!(ImageArticle, id)

  @doc """
  Creates a image_article.

  ## Examples

      iex> create_image_article(%{field: value})
      {:ok, %ImageArticle{}}

      iex> create_image_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image_article(attrs \\ %{}) do
    %ImageArticle{}
    |> ImageArticle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image_article.

  ## Examples

      iex> update_image_article(image_article, %{field: new_value})
      {:ok, %ImageArticle{}}

      iex> update_image_article(image_article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image_article(%ImageArticle{} = image_article, attrs) do
    image_article
    |> ImageArticle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a image_article.

  ## Examples

      iex> delete_image_article(image_article)
      {:ok, %ImageArticle{}}

      iex> delete_image_article(image_article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image_article(%ImageArticle{} = image_article) do
    Repo.delete(image_article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image_article changes.

  ## Examples

      iex> change_image_article(image_article)
      %Ecto.Changeset{data: %ImageArticle{}}

  """
  def change_image_article(%ImageArticle{} = image_article, attrs \\ %{}) do
    ImageArticle.changeset(image_article, attrs)
  end
end
