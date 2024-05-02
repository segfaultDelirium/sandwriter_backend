defmodule SandwriterBackend.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "images" do
    field :data, :binary
    field :title, :string
    field :deleted_at, :naive_datetime
    field :uploaded_by, :binary_id

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:data, :title, :deleted_at])
    |> validate_required([:data])
  end
end
