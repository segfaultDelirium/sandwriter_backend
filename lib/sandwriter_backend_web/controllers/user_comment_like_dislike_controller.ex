defmodule SandwriterBackendWeb.UserCommentLikeDislikeController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.UserCommentLikeDislikes
  alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, _params) do
    user_comment_like_dislikes = UserCommentLikeDislikes.list_user_comment_like_dislikes()
    render(conn, :index, user_comment_like_dislikes: user_comment_like_dislikes)
  end

  def create(conn, %{"user_comment_like_dislike" => user_comment_like_dislike_params}) do
    with {:ok, %UserCommentLikeDislike{} = user_comment_like_dislike} <- UserCommentLikeDislikes.create_user_comment_like_dislike(user_comment_like_dislike_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/user_comment_like_dislikes/#{user_comment_like_dislike}")
      |> render(:show, user_comment_like_dislike: user_comment_like_dislike)
    end
  end

  def show(conn, %{"id" => id}) do
    user_comment_like_dislike = UserCommentLikeDislikes.get_user_comment_like_dislike!(id)
    render(conn, :show, user_comment_like_dislike: user_comment_like_dislike)
  end

  def update(conn, %{"id" => id, "user_comment_like_dislike" => user_comment_like_dislike_params}) do
    user_comment_like_dislike = UserCommentLikeDislikes.get_user_comment_like_dislike!(id)

    with {:ok, %UserCommentLikeDislike{} = user_comment_like_dislike} <- UserCommentLikeDislikes.update_user_comment_like_dislike(user_comment_like_dislike, user_comment_like_dislike_params) do
      render(conn, :show, user_comment_like_dislike: user_comment_like_dislike)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_comment_like_dislike = UserCommentLikeDislikes.get_user_comment_like_dislike!(id)

    with {:ok, %UserCommentLikeDislike{}} <- UserCommentLikeDislikes.delete_user_comment_like_dislike(user_comment_like_dislike) do
      send_resp(conn, :no_content, "")
    end
  end
end
