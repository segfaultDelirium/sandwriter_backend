defmodule SandwriterBackend.Repo.Migrations.AddUniqueConstraintsToUserAttemp3 do
  use Ecto.Migration

  def change do
    # create unique_index(:users, [:display_name])
    # create unique_index(:users, [:email], where: "email IS NOT NULL")
    # create unique_index(:users, [:phone_number], where: "phone_number IS NOT NULL")
  end
end
