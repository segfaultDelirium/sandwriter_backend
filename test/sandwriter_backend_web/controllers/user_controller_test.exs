defmodule SandwriterBackendWeb.UserControllerTest do
  use SandwriterBackendWeb.ConnCase

  import SandwriterBackend.UsersFixtures

  alias SandwriterBackend.Users.User

  @create_attrs %{
    email: "some email",
    display_name: "some display_name",
    full_name: "some full_name",
    gender: "some gender",
    biography: "some biography",
    deleted_at: ~N[2024-04-15 09:11:00],
    phone_number: "some phone_number"
  }
  @update_attrs %{
    email: "some updated email",
    display_name: "some updated display_name",
    full_name: "some updated full_name",
    gender: "some updated gender",
    biography: "some updated biography",
    deleted_at: ~N[2024-04-16 09:11:00],
    phone_number: "some updated phone_number"
  }
  @invalid_attrs %{email: nil, display_name: nil, full_name: nil, gender: nil, biography: nil, deleted_at: nil, phone_number: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "biography" => "some biography",
               "deleted_at" => "2024-04-15T09:11:00",
               "display_name" => "some display_name",
               "email" => "some email",
               "full_name" => "some full_name",
               "gender" => "some gender",
               "phone_number" => "some phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "biography" => "some updated biography",
               "deleted_at" => "2024-04-16T09:11:00",
               "display_name" => "some updated display_name",
               "email" => "some updated email",
               "full_name" => "some updated full_name",
               "gender" => "some updated gender",
               "phone_number" => "some updated phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
