defmodule SandwriterBackendWeb.Auth.Pipeline do
  # use Guardian.Plug.Pipeline,
  #   otp_app: :sandwriter_backend,
  #   module: SandwriterBackendWeb.Auth.Guardian,
  #   error_handler: SandwriterBackendWeb.Auth.GuardianErrorHandler

  # plug Guardian.Plug.VerifySession
  # plug Guardian.Plug.VerifyHeader
  # plug Guardian.Plug.EnsureAuthenticated
  # plug Guardian.Plug.LoadResource

  use Guardian.Plug.Pipeline,
    otp_app: :sandwriter_backend,
    module: SandwriterBackendWeb.Auth.Guardian,
    error_handler: SandwriterBackendWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
