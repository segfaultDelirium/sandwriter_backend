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
end
