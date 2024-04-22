defmodule SandwriterBackend.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias SandwriterBackend.Repo

  alias SandwriterBackend.Comments.Comment
  alias SandwriterBackend.Accounts.Account
  alias SandwriterBackend.Users.User

  def get_by_article_id(article_id) do
    # Repo.all(Comment, article_id: article_id)
    query =
      from comment in Comment,
        join: account in Account,
        on: account.id == comment.author_id,
        join: user in User,
        on: user.account_id == account.id,
        where: comment.article_id == ^article_id,
        select: %{
          id: comment.id,
          text: comment.text,
          author_id: comment.author_id,
          display_name: user.display_name,
          article_id: comment.article_id,
          replies_to: comment.replies_to,
          inserted_at: comment.inserted_at,
          updated_at: comment.updated_at,
          deleted_at: comment.deleted_at
        }

    Repo.all(query)
  end

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
