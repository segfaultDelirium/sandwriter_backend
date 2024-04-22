defmodule SandwriterBackendWeb.ArticleJSON do
  alias SandwriterBackend.Articles.Article

  @doc """
  Renders a list of articles.
  """
  def index(%{articles: articles}) do
    %{data: for(article <- articles, do: data(article))}
  end

  @doc """
  Renders a single article.
  """
  def show(%{article: article}) do
    %{data: data(article)}
  end

  defp data(%Article{} = article) do
    %{
      id: article.id,
      title: article.title,
      slug: article.slug,
      text: article.text,
      deleted_at: article.deleted_at
    }
  end
end
