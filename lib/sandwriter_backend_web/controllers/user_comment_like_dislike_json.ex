defmodule SandwriterBackendWeb.UserCommentLikeDislikeJSON do
  alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike

  @doc """
  Renders a list of user_comment_like_dislikes.
  """
  def index(%{user_comment_like_dislikes: user_comment_like_dislikes}) do
    %{data: for(user_comment_like_dislike <- user_comment_like_dislikes, do: data(user_comment_like_dislike))}
  end

  @doc """
  Renders a single user_comment_like_dislike.
  """
  def show(%{user_comment_like_dislike: user_comment_like_dislike}) do
    %{data: data(user_comment_like_dislike)}
  end

  defp data(%UserCommentLikeDislike{} = user_comment_like_dislike) do
    %{
      id: user_comment_like_dislike.id,
      is_liked: user_comment_like_dislike.is_liked,
      is_disliked: user_comment_like_dislike.is_disliked
    }
  end
end
