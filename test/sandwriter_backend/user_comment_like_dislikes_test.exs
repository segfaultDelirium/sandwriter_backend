defmodule SandwriterBackend.UserCommentLikeDislikesTest do
  use SandwriterBackend.DataCase

  alias SandwriterBackend.UserCommentLikeDislikes

  describe "user_comment_like_dislikes" do
    alias SandwriterBackend.UserCommentLikeDislikes.UserCommentLikeDislike

    import SandwriterBackend.UserCommentLikeDislikesFixtures

    @invalid_attrs %{is_liked: nil, is_disliked: nil}

    test "list_user_comment_like_dislikes/0 returns all user_comment_like_dislikes" do
      user_comment_like_dislike = user_comment_like_dislike_fixture()
      assert UserCommentLikeDislikes.list_user_comment_like_dislikes() == [user_comment_like_dislike]
    end

    test "get_user_comment_like_dislike!/1 returns the user_comment_like_dislike with given id" do
      user_comment_like_dislike = user_comment_like_dislike_fixture()
      assert UserCommentLikeDislikes.get_user_comment_like_dislike!(user_comment_like_dislike.id) == user_comment_like_dislike
    end

    test "create_user_comment_like_dislike/1 with valid data creates a user_comment_like_dislike" do
      valid_attrs = %{is_liked: true, is_disliked: true}

      assert {:ok, %UserCommentLikeDislike{} = user_comment_like_dislike} = UserCommentLikeDislikes.create_user_comment_like_dislike(valid_attrs)
      assert user_comment_like_dislike.is_liked == true
      assert user_comment_like_dislike.is_disliked == true
    end

    test "create_user_comment_like_dislike/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserCommentLikeDislikes.create_user_comment_like_dislike(@invalid_attrs)
    end

    test "update_user_comment_like_dislike/2 with valid data updates the user_comment_like_dislike" do
      user_comment_like_dislike = user_comment_like_dislike_fixture()
      update_attrs = %{is_liked: false, is_disliked: false}

      assert {:ok, %UserCommentLikeDislike{} = user_comment_like_dislike} = UserCommentLikeDislikes.update_user_comment_like_dislike(user_comment_like_dislike, update_attrs)
      assert user_comment_like_dislike.is_liked == false
      assert user_comment_like_dislike.is_disliked == false
    end

    test "update_user_comment_like_dislike/2 with invalid data returns error changeset" do
      user_comment_like_dislike = user_comment_like_dislike_fixture()
      assert {:error, %Ecto.Changeset{}} = UserCommentLikeDislikes.update_user_comment_like_dislike(user_comment_like_dislike, @invalid_attrs)
      assert user_comment_like_dislike == UserCommentLikeDislikes.get_user_comment_like_dislike!(user_comment_like_dislike.id)
    end

    test "delete_user_comment_like_dislike/1 deletes the user_comment_like_dislike" do
      user_comment_like_dislike = user_comment_like_dislike_fixture()
      assert {:ok, %UserCommentLikeDislike{}} = UserCommentLikeDislikes.delete_user_comment_like_dislike(user_comment_like_dislike)
      assert_raise Ecto.NoResultsError, fn -> UserCommentLikeDislikes.get_user_comment_like_dislike!(user_comment_like_dislike.id) end
    end

    test "change_user_comment_like_dislike/1 returns a user_comment_like_dislike changeset" do
      user_comment_like_dislike = user_comment_like_dislike_fixture()
      assert %Ecto.Changeset{} = UserCommentLikeDislikes.change_user_comment_like_dislike(user_comment_like_dislike)
    end
  end
end
