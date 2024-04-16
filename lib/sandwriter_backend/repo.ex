defmodule SandwriterBackend.Repo do
  use Ecto.Repo,
    otp_app: :sandwriter_backend,
    adapter: Ecto.Adapters.Postgres
end
