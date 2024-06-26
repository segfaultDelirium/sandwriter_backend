defmodule SandwriterBackend.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "images" do
    field :data, :binary
    field :deleted_at, :naive_datetime

    # account id
    field :uploaded_by, :binary_id

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:data, :deleted_at, :uploaded_by])
    |> validate_required([:data, :uploaded_by])
  end

  def get_viewable_fields() do
    [:id, :data, :uploaded_by] ++
      Helpers.timestamp_fields()
  end
end
