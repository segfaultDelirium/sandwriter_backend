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
end
