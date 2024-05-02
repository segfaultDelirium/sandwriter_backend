defmodule SandwriterBackend.Repo.Migrations.CreateArticleTextSection do
  use Ecto.Migration

  def change do
    create table(:article_text_section, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :section_index, :integer
      add :text, :text
      add :article_id, references(:articles, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:article_text_section, [:article_id])
  end
end
