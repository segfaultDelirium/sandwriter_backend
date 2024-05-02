defmodule SandwriterBackend.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :title, :string
    field :slug, :string
    field :deleted_at, :naive_datetime
    field :author_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:author_id, :title, :slug, :deleted_at])
    |> validate_required([:author_id, :title, :slug])
  end
end
