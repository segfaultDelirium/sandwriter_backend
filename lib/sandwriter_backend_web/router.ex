defmodule SandwriterBackendWeb.Router do
  use SandwriterBackendWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, x) do
    IO.inspect(x)
    conn |> halt()
    # conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug SandwriterBackendWeb.Auth.Pipeline
  end

  scope "/api", SandwriterBackendWeb do
    pipe_through :api

    post "/accounts/create", AccountController, :create
    post "/accounts/login", AccountController, :login
    get "/unprotected/accounts/by_id/:id", AccountController, :show

    # get "/accounts", AccountController, :index
    # resources "/accounts", AccountController, except: [:new, :edit]
  end

  scope "/api", SandwriterBackendWeb do
    pipe_through [:api, :auth]
    get "/accounts/by_id/:id", AccountController, :show
  end
end
