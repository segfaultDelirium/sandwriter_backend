defmodule SandwriterBackendWeb.ArticleTextSectionControllerTest do
  use SandwriterBackendWeb.ConnCase

  import SandwriterBackend.ArticleTextSectionsFixtures

  alias SandwriterBackend.ArticleTextSections.ArticleTextSection

  @create_attrs %{
    text: "some text",
    section_index: 42
  }
  @update_attrs %{
    text: "some updated text",
    section_index: 43
  }
  @invalid_attrs %{text: nil, section_index: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all article_text_section", %{conn: conn} do
      conn = get(conn, ~p"/api/article_text_section")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create article_text_section" do
    test "renders article_text_section when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/article_text_section", article_text_section: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/article_text_section/#{id}")

      assert %{
               "id" => ^id,
               "section_index" => 42,
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/article_text_section", article_text_section: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article_text_section" do
    setup [:create_article_text_section]

    test "renders article_text_section when data is valid", %{conn: conn, article_text_section: %ArticleTextSection{id: id} = article_text_section} do
      conn = put(conn, ~p"/api/article_text_section/#{article_text_section}", article_text_section: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/article_text_section/#{id}")

      assert %{
               "id" => ^id,
               "section_index" => 43,
               "text" => "some updated text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, article_text_section: article_text_section} do
      conn = put(conn, ~p"/api/article_text_section/#{article_text_section}", article_text_section: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete article_text_section" do
    setup [:create_article_text_section]

    test "deletes chosen article_text_section", %{conn: conn, article_text_section: article_text_section} do
      conn = delete(conn, ~p"/api/article_text_section/#{article_text_section}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/article_text_section/#{article_text_section}")
      end
    end
  end

  defp create_article_text_section(_) do
    article_text_section = article_text_section_fixture()
    %{article_text_section: article_text_section}
  end
end
