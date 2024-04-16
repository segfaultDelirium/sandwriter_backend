defmodule SandwriterBackend.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        deleted_at: ~N[2024-04-15 09:11:00],
        hashed_password: "some hashed_password",
        login: "some login"
      })
      |> SandwriterBackend.Accounts.create_account()

    account
  end
end
