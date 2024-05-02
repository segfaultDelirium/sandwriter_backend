defmodule SandwriterBackendWeb.ImageArticleJSON do
  alias SandwriterBackend.ImageArticles.ImageArticle

  @doc """
  Renders a list of image_articles.
  """
  def index(%{image_articles: image_articles}) do
    %{data: for(image_article <- image_articles, do: data(image_article))}
  end

  @doc """
  Renders a single image_article.
  """
  def show(%{image_article: image_article}) do
    %{data: data(image_article)}
  end

  defp data(%ImageArticle{} = image_article) do
    %{
      id: image_article.id
    }
  end
end
