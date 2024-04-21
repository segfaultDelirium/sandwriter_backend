defmodule SandwriterBackendWeb.AccountController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackendWeb.Auth.ErrorResponse
  alias SandwriterBackend.{Accounts, Accounts.Account, Users, Users.User}
  # alias SandwriterBackend.Accounts.Account

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, params) do
    IO.inspect(params)
    IO.inspect(conn)
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def get_account_details(conn, _params) do
    account = conn.assigns[:account]

    # Ecto.assoc(account, )
    IO.inspect(account)

    # IO.inspect(account.user.email)

    conn
    |> put_status(:ok)
    |> render("account_details.json", %{account: account})
  end

  def create(conn, %{"account" => account_params}) do
    {:error, error_message} =
      SandwriterBackend.Repo.transaction(fn ->
        case Accounts.create_account(account_params) do
          {:ok, %Account{} = account} ->
            with {:ok, token, _claims} <-
                   SandwriterBackendWeb.Auth.Guardian.encode_and_sign(account) do
              try do
                case Users.create_user(account, account_params) do
                  {:ok, %User{} = _user} ->
                    conn
                    |> Plug.Conn.put_session(:account_id, account.id)
                    |> put_status(:created)
                    |> render("account_token.json", %{account: account, token: token})

                  _ ->
                    SandwriterBackend.Repo.rollback("Display name already taken.")
                end
              rescue
                Ecto.ConstraintError ->
                  SandwriterBackend.Repo.rollback("Display name already taken.")
              end
            end

          _ ->
            SandwriterBackend.Repo.rollback("Login already taken.")
        end
      end)

    conn
    |> put_status(:conflict)
    |> json(error_message)
  end

  def login(conn, %{"account" => account_params}) do
    case SandwriterBackendWeb.Auth.Guardian.authenticate(
           account_params["login"],
           account_params["hashed_password"]
         ) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> render("account_token.json", %{account: account, token: token})

      {:error, _} ->
        raise ErrorResponse.Unauthorized, message: "Login or password incorrect."

        conn
        |> put_status(:unauthorized)
        |> json(false)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.puts("hello from show")
    account = Accounts.get_account!(id)
    IO.puts("after getting account")
    IO.inspect(account)
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
