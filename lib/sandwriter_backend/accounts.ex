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
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
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
  Gets single account
  returns nil if the Account does not exist.
  ## Examples


    iex> get_account_by_login(sample_login)
    %Account{}

    iex> get_account_by_login(non_existing_login)
    nil
  """
  def get_account_by_login(login) do
    Account
    |> where(login: ^login)
    |> Repo.one()
  end

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

  # def create_account_and_user(attrs \\ %{}) do
  #   Ecto.Multi.new()
  #   |> Ecto.Multi.insert(:account, Account.changeset(%Account{}, attrs))
  #   |> Ecto.build_assoc(:user)
  #   |> User.changeset(attrs)
  #   |> Ecto.Multi.insert(:user)
  # end

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

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end
end
