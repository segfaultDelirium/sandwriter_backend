defmodule SandwriterBackend.ImageArticles.ImageArticle do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "image_articles" do
    field :article_id, :binary_id
    field :image_id, :binary_id
    field :title, :string
    field :section_index, :integer

    timestamps()
  end

  @doc false
  def changeset(image_article, attrs) do
    image_article
    |> cast(attrs, [:title, :section_index])
    |> validate_required([:title, :section_index])
  end
end
