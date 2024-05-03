defmodule SandwriterBackend.Helpers do
  def timestamp_fields() do
    [:inserted_at, :updated_at, :deleted_at]
  end

  def timestamp_fields_without_deleted() do
    [:inserted_at, :updated_at]
  end
end
