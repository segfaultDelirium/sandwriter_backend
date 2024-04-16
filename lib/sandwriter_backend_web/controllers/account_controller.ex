defmodule SandwriterBackendWeb.AccountController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.{Accounts, Accounts.Account, Users, Users.User}
  # alias SandwriterBackend.Accounts.Account

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.create_account(account_params) do
      {:ok, %Account{} = account} ->
        with {:ok, token, _claims} <- SandwriterBackendWeb.Auth.Guardian.encode_and_sign(account),
             {:ok, %User{} = user} <- Users.create_user(account, account_params) do
          conn
          |> put_status(:created)
          |> render("account_token.json", %{account: account, token: token})
        end

      _ ->
        conn
        |> put_status(:conflict)
        |> json("Login already taken.")
    end

    # with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
    #      {:ok, token, _claims} <- SandwriterBackendWeb.Auth.Guardian.encode_and_sign(account),
    #      {:ok, %User{} = user} <- Users.create_user(account, account_params) do
    #   conn
    #   |> put_status(:created)
    #   |> render("account_token.json", %{account: account, token: token})
    # else
    #   err ->
    #     conn
    #     |> put_status(:conflict)
    #     |> json(false)
    # end
  end

  def login(conn, %{"account" => account_params}) do
    case SandwriterBackendWeb.Auth.Guardian.authenticate(
           account_params["login"],
           account_params["hashed_password"]
         ) do
      {:ok, account, token} ->
        conn |> render("account_token.json", %{account: account, token: token})

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(false)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
