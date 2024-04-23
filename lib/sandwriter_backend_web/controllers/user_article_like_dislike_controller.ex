defmodule SandwriterBackendWeb.UserArticleLikeDislikeController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackendWeb.Auth.ErrorResponse.BadRequest
  alias SandwriterBackend.UserArticleLikeDislikes
  alias SandwriterBackend.UserArticleLikeDislikes.UserArticleLikeDislike

  action_fallback SandwriterBackendWeb.FallbackController

  def like_article(conn, %{"article_id" => article_id}) do
    account = conn.assigns[:account]

    case UserArticleLikeDislikes.get_by_article_id_and_user_id(article_id, account.id) do
      nil ->
        params = %{
          account_id: account.id,
          article_id: article_id,
          is_liked: true,
          is_disliked: false
        }

        case UserArticleLikeDislikes.create_user_article_like_dislike(params) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, _e} ->
            raise BadRequest
        end

        conn
        |> put_status(:ok)
        |> json(nil)

      user_article ->
        # IO.inspect(user_article)

        new_is_liked_status =
          if user_article.is_liked,
            do: false,
            else: true

        params = %{
          is_liked: new_is_liked_status,
          is_disliked: false
        }

        case UserArticleLikeDislikes.update_user_article_like_dislike(user_article, params) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, _e} ->
            raise BadRequest
        end
    end
  end

  def dislike_article(conn, %{"article_id" => article_id}) do
    account = conn.assigns[:account]

    case UserArticleLikeDislikes.get_by_article_id_and_user_id(article_id, account.id) do
      nil ->
        params = %{
          account_id: account.id,
          article_id: article_id,
          is_liked: false,
          is_disliked: true
        }

        case UserArticleLikeDislikes.create_user_article_like_dislike(params) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, _e} ->
            raise BadRequest
        end

        conn
        |> put_status(:ok)
        |> json(nil)

      user_article ->
        # IO.inspect(user_article)

        new_is_disliked_status =
          if user_article.is_disliked,
            do: false,
            else: true

        params = %{
          is_liked: false,
          is_disliked: new_is_disliked_status
        }

        case UserArticleLikeDislikes.update_user_article_like_dislike(user_article, params) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, _e} ->
            raise BadRequest
        end
    end
  end

  def index(conn, _params) do
    user_article_like_dislikes = UserArticleLikeDislikes.list_user_article_like_dislikes()
    render(conn, :index, user_article_like_dislikes: user_article_like_dislikes)
  end

  def create(conn, %{"user_article_like_dislike" => user_article_like_dislike_params}) do
    with {:ok, %UserArticleLikeDislike{} = user_article_like_dislike} <-
           UserArticleLikeDislikes.create_user_article_like_dislike(
             user_article_like_dislike_params
           ) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        ~p"/api/user_article_like_dislikes/#{user_article_like_dislike}"
      )
      |> render(:show, user_article_like_dislike: user_article_like_dislike)
    end
  end

  def show(conn, %{"id" => id}) do
    user_article_like_dislike = UserArticleLikeDislikes.get_user_article_like_dislike!(id)
    render(conn, :show, user_article_like_dislike: user_article_like_dislike)
  end

  def update(conn, %{"id" => id, "user_article_like_dislike" => user_article_like_dislike_params}) do
    user_article_like_dislike = UserArticleLikeDislikes.get_user_article_like_dislike!(id)

    with {:ok, %UserArticleLikeDislike{} = user_article_like_dislike} <-
           UserArticleLikeDislikes.update_user_article_like_dislike(
             user_article_like_dislike,
             user_article_like_dislike_params
           ) do
      render(conn, :show, user_article_like_dislike: user_article_like_dislike)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_article_like_dislike = UserArticleLikeDislikes.get_user_article_like_dislike!(id)

    with {:ok, %UserArticleLikeDislike{}} <-
           UserArticleLikeDislikes.delete_user_article_like_dislike(user_article_like_dislike) do
      send_resp(conn, :no_content, "")
    end
  end
end
