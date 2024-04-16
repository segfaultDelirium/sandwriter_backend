defmodule SandwriterBackend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :display_name, :string
    field :full_name, :string
    field :gender, :string
    field :biography, :string
    field :deleted_at, :naive_datetime
    field :phone_number, :string
    # field :account_id, :binary_id
    belongs_to :account, SandwriterBackend.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :display_name,
      :full_name,
      :gender,
      :biography,
      :deleted_at,
      :phone_number
    ])
    |> validate_required([:display_name])
    # |> unique_constraint(:display_name)

    |> unique_constraint([:display_name, :email, :phone_number])
  end
end
