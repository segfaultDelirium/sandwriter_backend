defmodule SandwriterBackend.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  import MapMerge
  alias SandwriterBackend.Repo

  alias SandwriterBackend.Comments.Comment
  alias SandwriterBackend.Accounts.Account
  alias SandwriterBackend.Users.User

  def get_by_article_id(article_id) do
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
          article_id: comment.article_id,
          replies_to: comment.replies_to,
          inserted_at: comment.inserted_at,
          updated_at: comment.updated_at,
          deleted_at: comment.deleted_at,
          author: %{
            id: user.id,
            email: user.email,
            display_name: user.display_name,
            full_name: user.full_name,
            gender: user.gender,
            biography: user.biography,
            phone_number: user.phone_number,
            inserted_at: user.inserted_at,
            updated_at: user.updated_at,
            deleted_at: user.deleted_at
          }
        }

    Repo.all(query)
  end

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
end
