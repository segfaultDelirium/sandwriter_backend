defmodule SandwriterBackend.UserArticleLikeDislikesTest do
  use SandwriterBackend.DataCase

  alias SandwriterBackend.UserArticleLikeDislikes

  describe "user_article_like_dislikes" do
    alias SandwriterBackend.UserArticleLikeDislikes.UserArticleLikeDislike

    import SandwriterBackend.UserArticleLikeDislikesFixtures

    @invalid_attrs %{is_liked: nil, is_disliked: nil}

    test "list_user_article_like_dislikes/0 returns all user_article_like_dislikes" do
      user_article_like_dislike = user_article_like_dislike_fixture()
      assert UserArticleLikeDislikes.list_user_article_like_dislikes() == [user_article_like_dislike]
    end

    test "get_user_article_like_dislike!/1 returns the user_article_like_dislike with given id" do
      user_article_like_dislike = user_article_like_dislike_fixture()
      assert UserArticleLikeDislikes.get_user_article_like_dislike!(user_article_like_dislike.id) == user_article_like_dislike
    end

    test "create_user_article_like_dislike/1 with valid data creates a user_article_like_dislike" do
      valid_attrs = %{is_liked: true, is_disliked: true}

      assert {:ok, %UserArticleLikeDislike{} = user_article_like_dislike} = UserArticleLikeDislikes.create_user_article_like_dislike(valid_attrs)
      assert user_article_like_dislike.is_liked == true
      assert user_article_like_dislike.is_disliked == true
    end

    test "create_user_article_like_dislike/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserArticleLikeDislikes.create_user_article_like_dislike(@invalid_attrs)
    end

    test "update_user_article_like_dislike/2 with valid data updates the user_article_like_dislike" do
      user_article_like_dislike = user_article_like_dislike_fixture()
      update_attrs = %{is_liked: false, is_disliked: false}

      assert {:ok, %UserArticleLikeDislike{} = user_article_like_dislike} = UserArticleLikeDislikes.update_user_article_like_dislike(user_article_like_dislike, update_attrs)
      assert user_article_like_dislike.is_liked == false
      assert user_article_like_dislike.is_disliked == false
    end

    test "update_user_article_like_dislike/2 with invalid data returns error changeset" do
      user_article_like_dislike = user_article_like_dislike_fixture()
      assert {:error, %Ecto.Changeset{}} = UserArticleLikeDislikes.update_user_article_like_dislike(user_article_like_dislike, @invalid_attrs)
      assert user_article_like_dislike == UserArticleLikeDislikes.get_user_article_like_dislike!(user_article_like_dislike.id)
    end

    test "delete_user_article_like_dislike/1 deletes the user_article_like_dislike" do
      user_article_like_dislike = user_article_like_dislike_fixture()
      assert {:ok, %UserArticleLikeDislike{}} = UserArticleLikeDislikes.delete_user_article_like_dislike(user_article_like_dislike)
      assert_raise Ecto.NoResultsError, fn -> UserArticleLikeDislikes.get_user_article_like_dislike!(user_article_like_dislike.id) end
    end

    test "change_user_article_like_dislike/1 returns a user_article_like_dislike changeset" do
      user_article_like_dislike = user_article_like_dislike_fixture()
      assert %Ecto.Changeset{} = UserArticleLikeDislikes.change_user_article_like_dislike(user_article_like_dislike)
    end
  end
end
