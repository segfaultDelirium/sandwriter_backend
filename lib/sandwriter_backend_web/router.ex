defmodule SandwriterBackendWeb.Router do
  use SandwriterBackendWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api", SandwriterBackendWeb do
    pipe_through :api

    post "/accounts/create", AccountController, :create
    post "/accounts/login", AccountController, :login

    # get "/accounts", AccountController, :index
    # resources "/accounts", AccountController, except: [:new, :edit]
  end
end
