defmodule SandwriterBackend.ArticleTextSections do
  @moduledoc """
  The ArticleTextSections context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo

  alias SandwriterBackend.ArticleTextSections.ArticleTextSection

  def create_all(text_sections) do
    current_datetime = NaiveDateTime.local_now()

    text_sections_with_timestamp =
      Enum.map(text_sections, fn x ->
        x
        |> Map.put(:inserted_at, current_datetime)
        |> Map.put(:updated_at, current_datetime)
      end)

    Repo.insert_all(ArticleTextSection, text_sections_with_timestamp)
  end

  def get_by_article_id(article_id) do
    query =
      from article_text_section in ArticleTextSection,
        where: article_text_section.article_id == ^article_id

    Repo.all(query)
  end

  @doc """
  Returns the list of article_text_section.

  ## Examples

      iex> list_article_text_section()
      [%ArticleTextSection{}, ...]

  """
  def list_article_text_section do
    Repo.all(ArticleTextSection)
  end

  @doc """
  Gets a single article_text_section.

  Raises `Ecto.NoResultsError` if the Article text section does not exist.

  ## Examples

      iex> get_article_text_section!(123)
      %ArticleTextSection{}

      iex> get_article_text_section!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article_text_section!(id), do: Repo.get!(ArticleTextSection, id)

  @doc """
  Creates a article_text_section.

  ## Examples

      iex> create_article_text_section(%{field: value})
      {:ok, %ArticleTextSection{}}

      iex> create_article_text_section(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article_text_section(attrs \\ %{}) do
    IO.inspect(attrs)

    %ArticleTextSection{}
    |> ArticleTextSection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article_text_section.

  ## Examples

      iex> update_article_text_section(article_text_section, %{field: new_value})
      {:ok, %ArticleTextSection{}}

      iex> update_article_text_section(article_text_section, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article_text_section(%ArticleTextSection{} = article_text_section, attrs) do
    article_text_section
    |> ArticleTextSection.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article_text_section.

  ## Examples

      iex> delete_article_text_section(article_text_section)
      {:ok, %ArticleTextSection{}}

      iex> delete_article_text_section(article_text_section)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article_text_section(%ArticleTextSection{} = article_text_section) do
    Repo.delete(article_text_section)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article_text_section changes.

  ## Examples

      iex> change_article_text_section(article_text_section)
      %Ecto.Changeset{data: %ArticleTextSection{}}

  """
  def change_article_text_section(%ArticleTextSection{} = article_text_section, attrs \\ %{}) do
    ArticleTextSection.changeset(article_text_section, attrs)
  end
end
