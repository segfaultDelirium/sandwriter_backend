defmodule SandwriterBackend.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        deleted_at: ~N[2024-04-15 09:11:00],
        display_name: "some display_name",
        email: "some email",
        full_name: "some full_name",
        gender: "some gender",
        phone_number: "some phone_number"
      })
      |> SandwriterBackend.Users.create_user()

    user
  end
end
