defmodule SandwriterBackend.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :text, :string
    field :deleted_at, :naive_datetime
    field :author_id, :binary_id
    field :replies_to, :binary_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :deleted_at])
    |> validate_required([:text])
  end
end
