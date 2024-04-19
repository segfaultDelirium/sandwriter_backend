defmodule SandwriterBackend.Repo.Migrations.AddUniqueConstraintsToUser do
  use Ecto.Migration

  def change do
    # create unique_index(:users, [:display_name, :email, :phone_number])
  end
end
