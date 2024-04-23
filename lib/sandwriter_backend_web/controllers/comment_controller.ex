defmodule SandwriterBackendWeb.CommentController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.Users
  alias SandwriterBackend.Comments
  alias SandwriterBackend.Comments.Comment
  alias SandwriterBackendWeb.Auth.ErrorResponse

  action_fallback SandwriterBackendWeb.FallbackController

  def comment_article(conn, %{"article_id" => article_id, "comment" => comment}) do
    account = conn.assigns[:account]
    user = Users.get_by_account_id(account.id)

    comment_params = %{
      article_id: article_id,
      text: comment,
      author_id: account.id
    }

    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        # IO.inspect(comment)

        conn
        |> put_status(:created)
        |> render("comment.json", %{comment: comment, user: user})

      {:error, _e} ->
        raise ErrorResponse.BadRequest, message: "Failed to create comment"
    end
  end

  def index(conn, _params) do
    comments = Comments.list_comments()
    render(conn, :index, comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Comments.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/comments/#{comment}")
      |> render(:show, comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, :show, comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Comments.update_comment(comment, comment_params) do
      render(conn, :show, comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
