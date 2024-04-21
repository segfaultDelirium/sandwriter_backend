defmodule SandwriterBackendWeb.UserJSON do
  alias SandwriterBackend.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      display_name: user.display_name,
      full_name: user.full_name,
      gender: user.gender,
      biography: user.biography,
      deleted_at: user.deleted_at,
      phone_number: user.phone_number,
      account_id: user.account_id
    }
  end
end
