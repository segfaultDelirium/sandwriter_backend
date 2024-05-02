defmodule SandwriterBackend.ImagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SandwriterBackend.Images` context.
  """

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        data: "some data",
        deleted_at: ~N[2024-05-01 10:42:00],
        title: "some title"
      })
      |> SandwriterBackend.Images.create_image()

    image
  end
end
