defmodule SandwriterBackendWeb.ImageArticleController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.ImageArticles
  alias SandwriterBackend.ImageArticles.ImageArticle

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, _params) do
    image_articles = ImageArticles.list_image_articles()
    render(conn, :index, image_articles: image_articles)
  end

  def create(conn, %{"image_article" => image_article_params}) do
    with {:ok, %ImageArticle{} = image_article} <- ImageArticles.create_image_article(image_article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/image_articles/#{image_article}")
      |> render(:show, image_article: image_article)
    end
  end

  def show(conn, %{"id" => id}) do
    image_article = ImageArticles.get_image_article!(id)
    render(conn, :show, image_article: image_article)
  end

  def update(conn, %{"id" => id, "image_article" => image_article_params}) do
    image_article = ImageArticles.get_image_article!(id)

    with {:ok, %ImageArticle{} = image_article} <- ImageArticles.update_image_article(image_article, image_article_params) do
      render(conn, :show, image_article: image_article)
    end
  end

  def delete(conn, %{"id" => id}) do
    image_article = ImageArticles.get_image_article!(id)

    with {:ok, %ImageArticle{}} <- ImageArticles.delete_image_article(image_article) do
      send_resp(conn, :no_content, "")
    end
  end
end
