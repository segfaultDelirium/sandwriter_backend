defmodule SandwriterBackend.ArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.Articles` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        deleted_at: ~N[2024-04-21 15:18:00],
        text: "some text",
        title: "some title"
      })
      |> SandwriterBackend.Articles.create_article()

    article
  end

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        deleted_at: ~N[2024-04-21 15:23:00],
        slug: "some slug",
        text: "some text",
        title: "some title"
      })
      |> SandwriterBackend.Articles.create_article()

    article
  end
end
