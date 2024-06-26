defmodule SandwriterBackendWeb.Auth.SetAccount do
  import Plug.Conn
  alias SandwriterBackendWeb.Auth.ErrorResponse
  alias SandwriterBackend.Accounts

  def init(_options) do
  end

  def call(conn, _options) do
    if conn.assigns[:account] do
      conn
    else
      # IO.inspect(conn)
      account_id = get_session(conn, :account_id)
      # IO.puts("account_id = #{account_id}")

      if account_id == nil, do: raise(ErrorResponse.Unauthorized)

      account = Accounts.get_account!(account_id)

      cond do
        account_id && account -> assign(conn, :account, account)
        true -> assign(conn, :account, nil)
      end
    end
  end
end
