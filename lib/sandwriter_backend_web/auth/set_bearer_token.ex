defmodule SandwriterBackendWeb.Auth.SetBearerToken do
  import Plug.Conn
  # alias SandwriterBackendWeb.Auth.ErrorResponse
  # alias SandwriterBackend.Accounts

  def init(_options) do
  end

  # read bearer token from cookie and set it in header 
  def call(conn, _options) do
    if conn.req_headers[:authorization] do
      conn
    else
      token = get_session(conn, :access_token)

      if token do
        conn
        |> put_req_header("authorization", "Bearer #{token}")

        # |> IO.inspect()
      else
        conn
      end
    end
  end
end
