defmodule SandwriterBackendWeb.UserController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.Users
  alias SandwriterBackend.Users.User

  action_fallback SandwriterBackendWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end
end
