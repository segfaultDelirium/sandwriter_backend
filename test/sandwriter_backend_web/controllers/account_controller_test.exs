defmodule SandwriterBackendWeb.AccountControllerTest do
  use SandwriterBackendWeb.ConnCase

  import SandwriterBackend.AccountsFixtures

  alias SandwriterBackend.Accounts.Account

  @create_attrs %{
    login: "some login",
    hashed_password: "some hashed_password",
    deleted_at: ~N[2024-04-15 09:11:00]
  }
  @update_attrs %{
    login: "some updated login",
    hashed_password: "some updated hashed_password",
    deleted_at: ~N[2024-04-16 09:11:00]
  }
  @invalid_attrs %{login: nil, hashed_password: nil, deleted_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "deleted_at" => "2024-04-15T09:11:00",
               "hashed_password" => "some hashed_password",
               "login" => "some login"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "deleted_at" => "2024-04-16T09:11:00",
               "hashed_password" => "some updated hashed_password",
               "login" => "some updated login"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/api/accounts/#{account}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/accounts/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
