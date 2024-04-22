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
end
