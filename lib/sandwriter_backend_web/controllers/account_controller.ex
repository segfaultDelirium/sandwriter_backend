defmodule SandwriterBackendWeb.AccountController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackendWeb.Auth.ErrorResponse
  alias SandwriterBackend.{Accounts, Accounts.Account, Users, Users.User}

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, params) do
    # IO.inspect(params)
    # IO.inspect(conn)
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def get_account_details(conn, _params) do
    account = conn.assigns[:account]
    user = Users.get_by_account_id(account.id)

    # Ecto.assoc(account, )
    # IO.inspect(account)

    # IO.inspect(account.user.email)

    conn
    |> put_status(:ok)
    |> render("account_details.json", %{account: account, user: user})
  end

  def get_token(conn, _params) do
    token = get_session(conn, :access_token)
    IO.puts("token: #{token}")
    conn |> json(token)
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
                    |> Plug.Conn.put_session(:access_token, token)
                    |> put_status(:created)
                    |> render("account.json", %{account: account})

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
        |> Plug.Conn.put_session(:access_token, token)
        |> render("account.json", %{account: account})

      # |> render("account_token.json", %{account: account, token: token})

      {:error, _} ->
        raise ErrorResponse.Unauthorized, message: "Login or password incorrect."

        conn
        |> put_status(:unauthorized)
        |> json(false)
    end
  end

  def logout(conn, params) do
    conn
    |> Plug.Conn.put_session(:account_id, nil)
    |> Plug.Conn.put_session(:access_token, nil)
    |> put_status(:ok)
    |> json(nil)
  end

  def change_details(conn, payload) do
    account = conn.assigns[:account]
    user = Users.get_by_account_id(account.id)
    # TODO
    SandwriterBackend.Repo.transaction(fn ->
      with {:ok, %User{} = user} <- Users.update_user(user, payload),
           {:ok, %Account{} = account} <- Accounts.update_account(account, payload) do
        # render(conn, :show, user: user)

        conn
        |> put_status(:ok)
        |> render("account_details.json", %{account: account, user: user})
      end
    end)
  end

  def change_password(conn, %{
        "old_password" => old_password,
        "new_password" => new_password,
        "new_password_repeated" => new_password_repeated
      }) do
    account = conn.assigns[:account]

    case SandwriterBackendWeb.Auth.Guardian.validate_password(
           old_password,
           account.hashed_password
         ) do
      false ->
        raise ErrorResponse.Unauthorized, message: "incorrect old password"

      true ->
        if new_password == new_password_repeated do
          # hashed_password = Bcrypt.hash_pwd_salt(new_password)
          Accounts.update_account(account, %{hashed_password: new_password})

          conn
          |> put_status(:ok)
          |> render("account.json", %{account: account})
        else
          raise ErrorResponse.BadRequest, message: "new password do not match repeated password"
        end
    end
  end

  def show(conn, %{"id" => id}) do
    # IO.puts("hello from show")
    account = Accounts.get_account!(id)
    # IO.puts("after getting account")
    # IO.inspect(account)
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
