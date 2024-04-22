defmodule SandwriterBackendWeb.UserArticleLikeDislikeController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.UserArticleLikeDislikes
  alias SandwriterBackend.UserArticleLikeDislikes.UserArticleLikeDislike

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, _params) do
    user_article_like_dislikes = UserArticleLikeDislikes.list_user_article_like_dislikes()
    render(conn, :index, user_article_like_dislikes: user_article_like_dislikes)
  end

  def create(conn, %{"user_article_like_dislike" => user_article_like_dislike_params}) do
    with {:ok, %UserArticleLikeDislike{} = user_article_like_dislike} <- UserArticleLikeDislikes.create_user_article_like_dislike(user_article_like_dislike_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/user_article_like_dislikes/#{user_article_like_dislike}")
      |> render(:show, user_article_like_dislike: user_article_like_dislike)
    end
  end

  def show(conn, %{"id" => id}) do
    user_article_like_dislike = UserArticleLikeDislikes.get_user_article_like_dislike!(id)
    render(conn, :show, user_article_like_dislike: user_article_like_dislike)
  end

  def update(conn, %{"id" => id, "user_article_like_dislike" => user_article_like_dislike_params}) do
    user_article_like_dislike = UserArticleLikeDislikes.get_user_article_like_dislike!(id)

    with {:ok, %UserArticleLikeDislike{} = user_article_like_dislike} <- UserArticleLikeDislikes.update_user_article_like_dislike(user_article_like_dislike, user_article_like_dislike_params) do
      render(conn, :show, user_article_like_dislike: user_article_like_dislike)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_article_like_dislike = UserArticleLikeDislikes.get_user_article_like_dislike!(id)

    with {:ok, %UserArticleLikeDislike{}} <- UserArticleLikeDislikes.delete_user_article_like_dislike(user_article_like_dislike) do
      send_resp(conn, :no_content, "")
    end
  end
end
