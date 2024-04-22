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
      inserted_at: article.inserted_at,
      updated_at: article.updated_at,
      deleted_at: article.deleted_at
    }
  end

  def render("article.json", %{article: article, user: user, comments: comments}) do
    %{
      author: %{display_name: user.display_name},
      comments:
        Enum.map(comments, fn comment ->
          %{
            id: comment.id,
            author_id: comment.author_id,
            author: %{display_name: comment.display_name},
            text: comment.text,
            inserted_at: comment.inserted_at,
            updated_at: comment.updated_at,
            deleted_at: comment.deleted_at
          }
        end),
      id: article.id,
      title: article.title,
      slug: article.slug,
      text: article.text,
      inserted_at: article.inserted_at,
      updated_at: article.updated_at,
      deleted_at: article.deleted_at
    }
  end
end
