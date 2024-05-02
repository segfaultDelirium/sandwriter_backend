defmodule SandwriterBackendWeb.ArticleTextSectionController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.ArticleTextSections
  alias SandwriterBackend.ArticleTextSections.ArticleTextSection

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, _params) do
    article_text_section = ArticleTextSections.list_article_text_section()
    render(conn, :index, article_text_section: article_text_section)
  end

  def create(conn, %{"article_text_section" => article_text_section_params}) do
    with {:ok, %ArticleTextSection{} = article_text_section} <- ArticleTextSections.create_article_text_section(article_text_section_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/article_text_section/#{article_text_section}")
      |> render(:show, article_text_section: article_text_section)
    end
  end

  def show(conn, %{"id" => id}) do
    article_text_section = ArticleTextSections.get_article_text_section!(id)
    render(conn, :show, article_text_section: article_text_section)
  end

  def update(conn, %{"id" => id, "article_text_section" => article_text_section_params}) do
    article_text_section = ArticleTextSections.get_article_text_section!(id)

    with {:ok, %ArticleTextSection{} = article_text_section} <- ArticleTextSections.update_article_text_section(article_text_section, article_text_section_params) do
      render(conn, :show, article_text_section: article_text_section)
    end
  end

  def delete(conn, %{"id" => id}) do
    article_text_section = ArticleTextSections.get_article_text_section!(id)

    with {:ok, %ArticleTextSection{}} <- ArticleTextSections.delete_article_text_section(article_text_section) do
      send_resp(conn, :no_content, "")
    end
  end
end
