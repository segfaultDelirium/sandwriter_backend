defmodule SandwriterBackend.ImageArticlesTest do
  use SandwriterBackend.DataCase

  alias SandwriterBackend.ImageArticles

  describe "image_articles" do
    alias SandwriterBackend.ImageArticles.ImageArticle

    import SandwriterBackend.ImageArticlesFixtures

    @invalid_attrs %{}

    test "list_image_articles/0 returns all image_articles" do
      image_article = image_article_fixture()
      assert ImageArticles.list_image_articles() == [image_article]
    end

    test "get_image_article!/1 returns the image_article with given id" do
      image_article = image_article_fixture()
      assert ImageArticles.get_image_article!(image_article.id) == image_article
    end

    test "create_image_article/1 with valid data creates a image_article" do
      valid_attrs = %{}

      assert {:ok, %ImageArticle{} = image_article} = ImageArticles.create_image_article(valid_attrs)
    end

    test "create_image_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ImageArticles.create_image_article(@invalid_attrs)
    end

    test "update_image_article/2 with valid data updates the image_article" do
      image_article = image_article_fixture()
      update_attrs = %{}

      assert {:ok, %ImageArticle{} = image_article} = ImageArticles.update_image_article(image_article, update_attrs)
    end

    test "update_image_article/2 with invalid data returns error changeset" do
      image_article = image_article_fixture()
      assert {:error, %Ecto.Changeset{}} = ImageArticles.update_image_article(image_article, @invalid_attrs)
      assert image_article == ImageArticles.get_image_article!(image_article.id)
    end

    test "delete_image_article/1 deletes the image_article" do
      image_article = image_article_fixture()
      assert {:ok, %ImageArticle{}} = ImageArticles.delete_image_article(image_article)
      assert_raise Ecto.NoResultsError, fn -> ImageArticles.get_image_article!(image_article.id) end
    end

    test "change_image_article/1 returns a image_article changeset" do
      image_article = image_article_fixture()
      assert %Ecto.Changeset{} = ImageArticles.change_image_article(image_article)
    end
  end
end
