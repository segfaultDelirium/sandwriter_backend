defmodule SandwriterBackendWeb.CommentJSON do
  def render("comment.json", %{comment: comment, user: user}) do
    %{
      id: comment.id,
      text: comment.text,
      author_id: comment.author_id,
      author: %{display_name: user.display_name},
      replies: [],
      likes: 0,
      dislikes: 0,
      is_liked_by_current_user: false,
      is_disliked_by_current_user: false,
      article_id: comment.article_id,
      replies_to: comment.replies_to,
      inserted_at: comment.inserted_at,
      updated_at: comment.updated_at,
      deleted_at: comment.deleted_at
    }
  end
end
