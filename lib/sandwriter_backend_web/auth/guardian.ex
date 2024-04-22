defmodule SandwriterBackendWeb.Auth.Guardian do
  use Guardian, otp_app: :sandwriter_backend

  alias SandwriterBackend.Accounts

  def subject_for_token(resource, _claims) do
    IO.puts("in subject_for_token")
    IO.inspect(resource)
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    IO.puts("in resource_from_claims")
    IO.inspect(claims)
    id = claims["sub"]

    case Accounts.get_by_id(id) do
      {:ok, account} -> {:ok, account}
      {:error, e} -> {:error, e}
    end
  end

  def authenticate(login, password) do
    case Accounts.get_by_login(login) do
      {:ok, account} ->
        case validate_password(password, account.hashed_password) do
          true -> create_token(account)
          false -> {:error, :reason_for_error}
        end

      {:error, e} ->
        {:error, e}
    end
  end

  def validate_password(password, hashed_password) do
    Bcrypt.verify_pass(password, hashed_password)
  end

  defp create_token(account) do
    {:ok, token, _full_claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
