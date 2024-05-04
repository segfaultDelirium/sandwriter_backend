defmodule SandwriterBackendWeb.UserCommentLikeDislikeController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.UserCommentLikeDislikes
  alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike
  alias SandwriterBackendWeb.Auth.ErrorResponse.BadRequest

  action_fallback SandwriterBackendWeb.FallbackController

  def like_comment(conn, %{"comment_id" => comment_id}) do
    account = conn.assigns[:account]

    case UserCommentLikeDislikes.get_by_comment_id_and_account_id(comment_id, account.id) do
      nil ->
        params = %{
          account_id: account.id,
          comment_id: comment_id,
          is_liked: true,
          is_disliked: false
        }

        case UserCommentLikeDislikes.create_user_comment_like_dislike(params) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, e} ->
            IO.inspect(e)
            raise BadRequest
        end

        IO.puts("created user_comment_like_dislike record")

        conn
        |> put_status(:ok)
        |> json(nil)

      user_comment ->
        IO.inspect(user_comment)

        new_is_liked_status =
          if user_comment.is_liked,
            do: false,
            else: true

        params = %{
          is_liked: new_is_liked_status,
          is_disliked: false
        }

        case UserCommentLikeDislikes.update_user_comment_like_dislike(user_comment, params) do
          {:ok, x} ->
            IO.puts("like_comment updating userCommentLikeDislikes")
            IO.inspect(x)

            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, _e} ->
            raise BadRequest
        end
    end
  end

  def dislike_comment(conn, %{"comment_id" => comment_id}) do
    account = conn.assigns[:account]

    case UserCommentLikeDislikes.get_by_comment_id_and_account_id(comment_id, account.id) do
      nil ->
        params = %{
          account_id: account.id,
          comment_id: comment_id,
          is_liked: false,
          is_disliked: true
        }

        case UserCommentLikeDislikes.create_user_comment_like_dislike(params) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, e} ->
            IO.inspect(e)
            raise BadRequest
        end

        conn
        |> put_status(:ok)
        |> json(nil)

      user_comment ->
        IO.inspect(user_comment)

        new_is_disliked_status =
          if user_comment.is_disliked,
            do: false,
            else: true

        params = %{
          is_liked: false,
          is_disliked: new_is_disliked_status
        }

        case UserCommentLikeDislikes.update_user_comment_like_dislike(user_comment, params) do
          {:ok, x} ->
            IO.puts("dislike_comment updating userCommentLikeDislikes")
            IO.inspect(x)

            conn
            |> put_status(:ok)
            |> json(nil)

          {:error, _e} ->
            raise BadRequest
        end
    end
  end

  def index(conn, _params) do
    user_comment_like_dislikes = UserCommentLikeDislikes.list_user_comment_like_dislikes()
    render(conn, :index, user_comment_like_dislikes: user_comment_like_dislikes)
  end

  def create(conn, %{"user_comment_like_dislike" => user_comment_like_dislike_params}) do
    with {:ok, %UserCommentLikeDislike{} = user_comment_like_dislike} <-
           UserCommentLikeDislikes.create_user_comment_like_dislike(
             user_comment_like_dislike_params
           ) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        ~p"/api/user_comment_like_dislikes/#{user_comment_like_dislike}"
      )
      |> render(:show, user_comment_like_dislike: user_comment_like_dislike)
    end
  end

  def show(conn, %{"id" => id}) do
    user_comment_like_dislike = UserCommentLikeDislikes.get_user_comment_like_dislike!(id)
    render(conn, :show, user_comment_like_dislike: user_comment_like_dislike)
  end

  def update(conn, %{"id" => id, "user_comment_like_dislike" => user_comment_like_dislike_params}) do
    user_comment_like_dislike = UserCommentLikeDislikes.get_user_comment_like_dislike!(id)

    with {:ok, %UserCommentLikeDislike{} = user_comment_like_dislike} <-
           UserCommentLikeDislikes.update_user_comment_like_dislike(
             user_comment_like_dislike,
             user_comment_like_dislike_params
           ) do
      render(conn, :show, user_comment_like_dislike: user_comment_like_dislike)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_comment_like_dislike = UserCommentLikeDislikes.get_user_comment_like_dislike!(id)

    with {:ok, %UserCommentLikeDislike{}} <-
           UserCommentLikeDislikes.delete_user_comment_like_dislike(user_comment_like_dislike) do
      send_resp(conn, :no_content, "")
    end
  end
end
