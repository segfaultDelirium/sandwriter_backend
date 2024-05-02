defmodule SandwriterBackendWeb.ImageArticleControllerTest do
  use SandwriterBackendWeb.ConnCase

  import SandwriterBackend.ImageArticlesFixtures

  alias SandwriterBackend.ImageArticles.ImageArticle

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all image_articles", %{conn: conn} do
      conn = get(conn, ~p"/api/image_articles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image_article" do
    test "renders image_article when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/image_articles", image_article: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/image_articles/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/image_articles", image_article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image_article" do
    setup [:create_image_article]

    test "renders image_article when data is valid", %{conn: conn, image_article: %ImageArticle{id: id} = image_article} do
      conn = put(conn, ~p"/api/image_articles/#{image_article}", image_article: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/image_articles/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, image_article: image_article} do
      conn = put(conn, ~p"/api/image_articles/#{image_article}", image_article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image_article" do
    setup [:create_image_article]

    test "deletes chosen image_article", %{conn: conn, image_article: image_article} do
      conn = delete(conn, ~p"/api/image_articles/#{image_article}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/image_articles/#{image_article}")
      end
    end
  end

  defp create_image_article(_) do
    image_article = image_article_fixture()
    %{image_article: image_article}
  end
end
