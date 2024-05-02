defmodule SandwriterBackend.ImageArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.ImageArticles` context.
  """

  @doc """
  Generate a image_article.
  """
  def image_article_fixture(attrs \\ %{}) do
    {:ok, image_article} =
      attrs
      |> Enum.into(%{

      })
      |> SandwriterBackend.ImageArticles.create_image_article()

    image_article
  end
end
