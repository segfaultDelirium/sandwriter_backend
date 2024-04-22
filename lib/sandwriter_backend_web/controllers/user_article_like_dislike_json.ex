defmodule SandwriterBackendWeb.UserArticleLikeDislikeJSON do
  alias SandwriterBackend.UserArticleLikeDislikes.UserArticleLikeDislike

  @doc """
  Renders a list of user_article_like_dislikes.
  """
  def index(%{user_article_like_dislikes: user_article_like_dislikes}) do
    %{data: for(user_article_like_dislike <- user_article_like_dislikes, do: data(user_article_like_dislike))}
  end

  @doc """
  Renders a single user_article_like_dislike.
  """
  def show(%{user_article_like_dislike: user_article_like_dislike}) do
    %{data: data(user_article_like_dislike)}
  end

  defp data(%UserArticleLikeDislike{} = user_article_like_dislike) do
    %{
      id: user_article_like_dislike.id,
      is_liked: user_article_like_dislike.is_liked,
      is_disliked: user_article_like_dislike.is_disliked
    }
  end
end
