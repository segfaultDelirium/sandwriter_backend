defmodule SandwriterBackend.ArticleTextSectionsTest do
  use SandwriterBackend.DataCase

  alias SandwriterBackend.ArticleTextSections

  describe "article_text_section" do
    alias SandwriterBackend.ArticleTextSections.ArticleTextSection

    import SandwriterBackend.ArticleTextSectionsFixtures

    @invalid_attrs %{text: nil, section_index: nil}

    test "list_article_text_section/0 returns all article_text_section" do
      article_text_section = article_text_section_fixture()
      assert ArticleTextSections.list_article_text_section() == [article_text_section]
    end

    test "get_article_text_section!/1 returns the article_text_section with given id" do
      article_text_section = article_text_section_fixture()
      assert ArticleTextSections.get_article_text_section!(article_text_section.id) == article_text_section
    end

    test "create_article_text_section/1 with valid data creates a article_text_section" do
      valid_attrs = %{text: "some text", section_index: 42}

      assert {:ok, %ArticleTextSection{} = article_text_section} = ArticleTextSections.create_article_text_section(valid_attrs)
      assert article_text_section.text == "some text"
      assert article_text_section.section_index == 42
    end

    test "create_article_text_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ArticleTextSections.create_article_text_section(@invalid_attrs)
    end

    test "update_article_text_section/2 with valid data updates the article_text_section" do
      article_text_section = article_text_section_fixture()
      update_attrs = %{text: "some updated text", section_index: 43}

      assert {:ok, %ArticleTextSection{} = article_text_section} = ArticleTextSections.update_article_text_section(article_text_section, update_attrs)
      assert article_text_section.text == "some updated text"
      assert article_text_section.section_index == 43
    end

    test "update_article_text_section/2 with invalid data returns error changeset" do
      article_text_section = article_text_section_fixture()
      assert {:error, %Ecto.Changeset{}} = ArticleTextSections.update_article_text_section(article_text_section, @invalid_attrs)
      assert article_text_section == ArticleTextSections.get_article_text_section!(article_text_section.id)
    end

    test "delete_article_text_section/1 deletes the article_text_section" do
      article_text_section = article_text_section_fixture()
      assert {:ok, %ArticleTextSection{}} = ArticleTextSections.delete_article_text_section(article_text_section)
      assert_raise Ecto.NoResultsError, fn -> ArticleTextSections.get_article_text_section!(article_text_section.id) end
    end

    test "change_article_text_section/1 returns a article_text_section changeset" do
      article_text_section = article_text_section_fixture()
      assert %Ecto.Changeset{} = ArticleTextSections.change_article_text_section(article_text_section)
    end
  end
end
