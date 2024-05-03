defmodule SandwriterBackend.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo

  alias SandwriterBackend.Accounts.Account

  def get_by_login(login) do
    case Repo.get_by(Account, login: login) do
      nil ->
        {:error, :not_found}

      account ->
        {:ok, account}
    end
  end

  def get_by_id(id) do
    case Repo.get(Account, id) do
      nil ->
        {:error, :not_found}

      account ->
        {:ok, account}
    end
  end

  def authenticate_account(login, password) do
    with {:ok, account} <- get_by_login(login) do
      case validate_password(password, account.hashed_password) do
        false -> {:error, :unauthorized}
        true -> {:ok, account}
      end
    end
  end

  defp validate_password(password, password_from_db) do
    Bcrypt.verify_pass(password, password_from_db)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end
end
