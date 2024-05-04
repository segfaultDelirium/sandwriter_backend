defmodule SandwriterBackend.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias SandwriterBackend.Helpers

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :text, :string
    field :deleted_at, :naive_datetime
    field :author_id, :binary_id

    # different comment id
    field :replies_to, :binary_id
    field :article_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author_id, :article_id, :text, :deleted_at, :replies_to])
    |> validate_required([:author_id, :article_id, :text])
  end

  def get_viewable_fields() do
    [:id, :text, :author_id, :article_id, :replies_to] ++ Helpers.timestamp_fields()
  end
end
