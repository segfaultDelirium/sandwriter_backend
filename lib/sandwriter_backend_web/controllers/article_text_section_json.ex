defmodule SandwriterBackendWeb.ArticleTextSectionJSON do
  alias SandwriterBackend.ArticleTextSections.ArticleTextSection

  @doc """
  Renders a list of article_text_section.
  """
  def index(%{article_text_section: article_text_section}) do
    %{data: for(article_text_section <- article_text_section, do: data(article_text_section))}
  end

  @doc """
  Renders a single article_text_section.
  """
  def show(%{article_text_section: article_text_section}) do
    %{data: data(article_text_section)}
  end

  defp data(%ArticleTextSection{} = article_text_section) do
    %{
      id: article_text_section.id,
      section_index: article_text_section.section_index,
      text: article_text_section.text
    }
  end
end
