defmodule SandwriterBackendWeb.Router do
  use SandwriterBackendWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api", SandwriterBackendWeb do
    pipe_through :api
  end
end
