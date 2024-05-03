defmodule SandwriterBackendWeb.AccountJSON do
  alias SandwriterBackend.Accounts.Account
  alias SandwriterBackend.Users.User
  import MapMerge

  def render("account.json", %{account: account}) do
    Map.take(account, [:id, :login])
  end

  def render("account_details.json", %{account: account, user: user}) do
    Map.take(account, [:id, :login]) ||| render("user_details.json", %{user: user})
  end

  def render("user_details.json", %{user: user}) do
    Map.take(user, User.get_viewable_fields())
  end
end
