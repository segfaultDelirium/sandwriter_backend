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
end
