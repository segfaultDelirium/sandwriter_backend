defmodule SandwriterBackend.ImagesTest do
  use SandwriterBackend.DataCase

  alias SandwriterBackend.Images

  describe "images" do
    alias SandwriterBackend.Images.Image

    import SandwriterBackend.ImagesFixtures

    @invalid_attrs %{data: nil, title: nil, deleted_at: nil}

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Images.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Images.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      valid_attrs = %{data: "some data", title: "some title", deleted_at: ~N[2024-05-01 10:42:00]}

      assert {:ok, %Image{} = image} = Images.create_image(valid_attrs)
      assert image.data == "some data"
      assert image.title == "some title"
      assert image.deleted_at == ~N[2024-05-01 10:42:00]
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Images.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      update_attrs = %{data: "some updated data", title: "some updated title", deleted_at: ~N[2024-05-02 10:42:00]}

      assert {:ok, %Image{} = image} = Images.update_image(image, update_attrs)
      assert image.data == "some updated data"
      assert image.title == "some updated title"
      assert image.deleted_at == ~N[2024-05-02 10:42:00]
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Images.update_image(image, @invalid_attrs)
      assert image == Images.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Images.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Images.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Images.change_image(image)
    end
  end
end
