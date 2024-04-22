defmodule SandwriterBackend.UserArticleLikeDislikesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.UserArticleLikeDislikes` context.
  """

  @doc """
  Generate a user_article_like_dislike.
  """
  def user_article_like_dislike_fixture(attrs \\ %{}) do
    {:ok, user_article_like_dislike} =
      attrs
      |> Enum.into(%{
        is_disliked: true,
        is_liked: true
      })
      |> SandwriterBackend.UserArticleLikeDislikes.create_user_article_like_dislike()

    user_article_like_dislike
  end
end
