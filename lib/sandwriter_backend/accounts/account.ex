defmodule SandwriterBackend.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :login, :string
    field :hashed_password, :string
    field :deleted_at, :naive_datetime
    has_one :user, SandwriterBackend.Users.User

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:login, :hashed_password, :deleted_at])
    |> validate_required([:login, :hashed_password])
    |> unique_constraint(:login)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{hashed_password: hashed_password}} = changeset
       ) do
    change(changeset, hashed_password: Bcrypt.hash_pwd_salt(hashed_password))
  end

  defp put_password_hash(changeset), do: changeset
end
