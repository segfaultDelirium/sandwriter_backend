defmodule SandwriterBackendWeb.Auth.AccentPlug do
  import Plug.Conn

  def init(_options) do
  end

  def call(conn, _options) do
    # IO.puts("initial conn")
    # IO.inspect(conn)

    snake_case_params = snake_case_map_keys(conn.params)
    snake_case_body_params = snake_case_map_keys(conn.body_params)

    conn
    |> Map.replace(:params, snake_case_params)
    |> Map.replace(:body_params, snake_case_body_params)

    # |> IO.inspect()
  end

  def snake_case_response_json(conn) do
    IO.puts("Hello from snake_case_response_json")
    IO.inspect(conn)
  end

  defp snake_case_map_keys(%Date{} = val), do: val
  defp snake_case_map_keys(%Plug.Upload{} = val), do: val
  defp snake_case_map_keys(%DateTime{} = val), do: val
  defp snake_case_map_keys(%NaiveDateTime{} = val), do: val

  defp snake_case_map_keys(map) when is_map(map) do
    for {key, val} <- map, into: %{} do
      {Inflex.underscore(key), snake_case_map_keys(val)}
    end
  end

  defp snake_case_map_keys(val), do: val
end
