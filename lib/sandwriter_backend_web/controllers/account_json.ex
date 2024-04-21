defmodule SandwriterBackendWeb.AccountJSON do
  alias SandwriterBackend.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      login: account.login,
      hashed_password: account.hashed_password,
      deleted_at: account.deleted_at
    }
  end

  def render("account_token.json", %{account: account, token: token}) do
    %{
      id: account.id,
      login: account.login,
      token: token
    }
  end

  def render("account_details.json", %{account: account, user: user}) do
    %{
      id: account.id,
      login: account.login,
      email: user.email,
      display_name: user.display_name,
      full_name: user.full_name,
      gender: user.gender,
      biography: user.biography,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
      deleted_at: user.deleted_at,
      phone_number: user.phone_number
    }
  end
end
