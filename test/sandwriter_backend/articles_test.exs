defmodule SandwriterBackend.ArticlesTest do
  use SandwriterBackend.DataCase

  alias SandwriterBackend.Articles

  describe "articles" do
    alias SandwriterBackend.Articles.Article

    import SandwriterBackend.ArticlesFixtures

    @invalid_attrs %{title: nil, text: nil, deleted_at: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{title: "some title", text: "some text", deleted_at: ~N[2024-04-21 15:18:00]}

      assert {:ok, %Article{} = article} = Articles.create_article(valid_attrs)
      assert article.title == "some title"
      assert article.text == "some text"
      assert article.deleted_at == ~N[2024-04-21 15:18:00]
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{title: "some updated title", text: "some updated text", deleted_at: ~N[2024-04-22 15:18:00]}

      assert {:ok, %Article{} = article} = Articles.update_article(article, update_attrs)
      assert article.title == "some updated title"
      assert article.text == "some updated text"
      assert article.deleted_at == ~N[2024-04-22 15:18:00]
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end

  describe "articles" do
    alias SandwriterBackend.Articles.Article

    import SandwriterBackend.ArticlesFixtures

    @invalid_attrs %{title: nil, text: nil, slug: nil, deleted_at: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{title: "some title", text: "some text", slug: "some slug", deleted_at: ~N[2024-04-21 15:23:00]}

      assert {:ok, %Article{} = article} = Articles.create_article(valid_attrs)
      assert article.title == "some title"
      assert article.text == "some text"
      assert article.slug == "some slug"
      assert article.deleted_at == ~N[2024-04-21 15:23:00]
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{title: "some updated title", text: "some updated text", slug: "some updated slug", deleted_at: ~N[2024-04-22 15:23:00]}

      assert {:ok, %Article{} = article} = Articles.update_article(article, update_attrs)
      assert article.title == "some updated title"
      assert article.text == "some updated text"
      assert article.slug == "some updated slug"
      assert article.deleted_at == ~N[2024-04-22 15:23:00]
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end
end
