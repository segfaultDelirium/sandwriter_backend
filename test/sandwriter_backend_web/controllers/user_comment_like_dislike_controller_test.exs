defmodule SandwriterBackendWeb.UserCommentLikeDislikeControllerTest do
  use SandwriterBackendWeb.ConnCase

  import SandwriterBackend.UserCommentLikeDislikesFixtures

  alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike

  @create_attrs %{
    is_liked: true,
    is_disliked: true
  }
  @update_attrs %{
    is_liked: false,
    is_disliked: false
  }
  @invalid_attrs %{is_liked: nil, is_disliked: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_comment_like_dislikes", %{conn: conn} do
      conn = get(conn, ~p"/api/user_comment_like_dislikes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_comment_like_dislike" do
    test "renders user_comment_like_dislike when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/user_comment_like_dislikes", user_comment_like_dislike: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/user_comment_like_dislikes/#{id}")

      assert %{
               "id" => ^id,
               "is_disliked" => true,
               "is_liked" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/user_comment_like_dislikes", user_comment_like_dislike: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_comment_like_dislike" do
    setup [:create_user_comment_like_dislike]

    test "renders user_comment_like_dislike when data is valid", %{conn: conn, user_comment_like_dislike: %UserCommentLikeDislike{id: id} = user_comment_like_dislike} do
      conn = put(conn, ~p"/api/user_comment_like_dislikes/#{user_comment_like_dislike}", user_comment_like_dislike: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/user_comment_like_dislikes/#{id}")

      assert %{
               "id" => ^id,
               "is_disliked" => false,
               "is_liked" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_comment_like_dislike: user_comment_like_dislike} do
      conn = put(conn, ~p"/api/user_comment_like_dislikes/#{user_comment_like_dislike}", user_comment_like_dislike: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_comment_like_dislike" do
    setup [:create_user_comment_like_dislike]

    test "deletes chosen user_comment_like_dislike", %{conn: conn, user_comment_like_dislike: user_comment_like_dislike} do
      conn = delete(conn, ~p"/api/user_comment_like_dislikes/#{user_comment_like_dislike}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/user_comment_like_dislikes/#{user_comment_like_dislike}")
      end
    end
  end

  defp create_user_comment_like_dislike(_) do
    user_comment_like_dislike = user_comment_like_dislike_fixture()
    %{user_comment_like_dislike: user_comment_like_dislike}
  end
end
