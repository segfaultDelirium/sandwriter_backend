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
    # IO.inspect(x)
    conn |> halt()
    # conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    # plug CORSPlug
    plug CORSPlug, origin: ["http://localhost:4200"]
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug SandwriterBackendWeb.Auth.SetBearerToken
    plug SandwriterBackendWeb.Auth.Pipeline
    plug SandwriterBackendWeb.Auth.SetAccount
  end

  scope "/api", SandwriterBackendWeb do
    pipe_through :api

    post "/accounts/create", AccountController, :create
    post "/accounts/login", AccountController, :login
    get "/unprotected/accounts/by_id/:id", AccountController, :show
  end

  scope "/api", SandwriterBackendWeb do
    pipe_through [:api, :auth]
    get "/accounts/by_id/:id", AccountController, :show
    get "/accounts", AccountController, :index
    get "/accounts/details", AccountController, :get_account_details
    get "/users", UserController, :index
    get "/accounts/get-token", AccountController, :get_token
    post "/accounts/change-details", AccountController, :change_details
    post "/accounts/change-password", AccountController, :change_password
    post "/accounts/logout", AccountController, :logout

    get "/articles/:slug", ArticleController, :get_article
    post "/articles/put-sample-article", ArticleController, :put_sample_article
    post "/comments/to-article/:article_id", CommentController, :comment_article
  end
end
