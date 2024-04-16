# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :sandwriter_backend,
  ecto_repos: [SandwriterBackend.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :sandwriter_backend, SandwriterBackendWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: SandwriterBackendWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SandwriterBackend.PubSub,
  live_view: [signing_salt: "ukrwGHcs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sandwriter_backend, SandwriterBackendWeb.Auth.Guardian,
  issuer: "sandwriter_backend",
  secret_key: "NVElG78z99Nun1dKi6Ci+347DDukw1b7h98rlDYeI2XfKFUxWTLeRThxFT3P+ibG"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
