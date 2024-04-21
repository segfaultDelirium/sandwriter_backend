defmodule SandwriterBackendWeb.Auth.Guardian do
  use Guardian, otp_app: :sandwriter_backend

  alias SandwriterBackendWeb.Guardian

  alias SandwriterBackend.Users
  alias SandwriterBackend.Repo
  alias SandwriterBackend.Account
  alias SandwriterBackend.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :no_id_provided}

  def resource_by_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_by_claims(_claims) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    Accounts.get_account!(id)
  end

  def authenticate(login, password) do
    # IO.inspect("login: #{login}")
    # IO.inspect("password: #{password}")

    case Accounts.get_account_by_login(login) do
      nil ->
        IO.puts("account not found")
        {:error, :unauthorized}

      account ->
        # IO.puts(password)
        # IO.puts(account.hashed_password)

        case validate_password(password, account.hashed_password) do
          true ->
            IO.puts("password validated!")
            create_token(account)

          false ->
            IO.puts("failed to validate password")
            {:error, :unauthorized}
        end
    end
  end

  defp validate_password(password, hashed_password) do
    Bcrypt.verify_pass(password, hashed_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
