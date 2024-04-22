defmodule SandwriterBackend.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        deleted_at: ~N[2024-04-21 15:18:00],
        text: "some text"
      })
      |> SandwriterBackend.Comments.create_comment()

    comment
  end
end
