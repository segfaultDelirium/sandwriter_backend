defmodule SandwriterBackend.ArticleTextSectionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.ArticleTextSections` context.
  """

  @doc """
  Generate a article_text_section.
  """
  def article_text_section_fixture(attrs \\ %{}) do
    {:ok, article_text_section} =
      attrs
      |> Enum.into(%{
        section_index: 42,
        text: "some text"
      })
      |> SandwriterBackend.ArticleTextSections.create_article_text_section()

    article_text_section
  end
end
