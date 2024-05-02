defmodule SandwriterBackend.ImageArticles do
  @moduledoc """
  The ImageArticles context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo
  alias SandwriterBackend.Images.Image

  alias SandwriterBackend.ImageArticles.ImageArticle

  def create_all(image_sections) do
    current_datetime = NaiveDateTime.local_now()

    image_sections_with_timestamps =
      Enum.map(image_sections, fn x ->
        x
        |> Map.put(:inserted_at, current_datetime)
        |> Map.put(:updated_at, current_datetime)
      end)

    Repo.insert_all(ImageArticle, image_sections_with_timestamps)
  end

  def get_by_article_id(article_id) do
    query =
      from image_article in ImageArticle,
        join: image in Image,
        on: image.id == image_article.image_id,
        where: image_article.article_id == ^article_id,
        select: %{
          image_id: image.id,
          section_index: image_article.section_index,
          title: image_article.title,
          data: image.data
        }

    Repo.all(query)
  end

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
