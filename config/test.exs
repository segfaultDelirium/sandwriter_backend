import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :sandwriter_backend, SandwriterBackend.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "sandwriter_backend_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sandwriter_backend, SandwriterBackendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4CEE3dTadlKL/rPZ1Wu1AWRW8OyW3KIHPgX9b9SP+AABgm1Oru2nWg8p2mbn0miC",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
