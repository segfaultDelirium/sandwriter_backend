defmodule SandwriterBackendWeb.CommentJSON do
  alias SandwriterBackend.Comments.Comment

  @doc """
  Renders a list of comments.
  """
  def index(%{comments: comments}) do
    %{data: for(comment <- comments, do: data(comment))}
  end

  @doc """
  Renders a single comment.
  """
  def show(%{comment: comment}) do
    %{data: data(comment)}
  end

  defp data(%Comment{} = comment) do
    %{
      id: comment.id,
      text: comment.text,
      deleted_at: comment.deleted_at
    }
  end

  def render("comment.json", %{comment: comment, user: user}) do
    %{
      id: comment.id,
      text: comment.text,
      author_id: comment.author_id,
      author: %{display_name: user.display_name},
      replies: [],
      upvotes: [],
      downvotes: [],
      is_upvoted_by_current_user: false,
      is_downvoted_by_current_user: false,
      article_id: comment.article_id,
      replies_to: comment.replies_to,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at,
      deleted_at: comment.deleted_at
    }
  end
end
