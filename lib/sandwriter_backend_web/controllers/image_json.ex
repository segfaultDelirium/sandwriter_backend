defmodule SandwriterBackendWeb.ImageJSON do
  alias SandwriterBackend.Images.Image

  @doc """
  Renders a list of images.
  """
  def index(%{images: images}) do
    %{data: for(image <- images, do: show(image))}
  end

  @doc """
  Renders a single image.
  """
  def show(%{image: image}) do
    %{
      id: image.id,
      data: Base.encode64(image.data),
      title: image.title,
      deleted_at: image.deleted_at
    }
  end
end
