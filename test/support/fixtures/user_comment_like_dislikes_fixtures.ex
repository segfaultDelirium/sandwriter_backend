defmodule SandwriterBackend.UserCommentLikeDislikesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.UserCommentLikeDislikes` context.
  """

  @doc """
  Generate a user_comment_like_dislike.
  """
  def user_comment_like_dislike_fixture(attrs \\ %{}) do
    {:ok, user_comment_like_dislike} =
      attrs
      |> Enum.into(%{
        is_disliked: true,
        is_liked: true
      })
      |> SandwriterBackend.UserCommentLikeDislikes.create_user_comment_like_dislike()

    user_comment_like_dislike
  end
end
