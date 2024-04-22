defmodule SandwriterBackendWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule SandwriterBackendWeb.Auth.ErrorResponse.BadRequest do
  defexception message: "BadRequest", plug_status: 400
end
