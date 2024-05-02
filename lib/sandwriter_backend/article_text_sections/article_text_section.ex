defmodule SandwriterBackend.ArticleTextSections.ArticleTextSection do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "article_text_section" do
    field :text, :string
    field :section_index, :integer
    # belongs_to :article, SandwriterBackend.Articles.Article
    field :article_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(article_text_section, attrs) do
    article_text_section
    # |> cast(attrs, [:section_index, :text])
    # |> validate_required([:section_index, :text])

    |> cast(attrs, [:section_index, :text, :article_id])
    |> validate_required([:section_index, :text, :article_id])
  end
end
