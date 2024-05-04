defmodule SandwriterBackendWeb.ImageController do
  use SandwriterBackendWeb, :controller

  alias SandwriterBackend.Images
  alias SandwriterBackend.Images.Image
  alias SandwriterBackend.{ImageArticles}

  action_fallback SandwriterBackendWeb.FallbackController

  def upload(conn, params) do
    account = conn.assigns[:account]
    # IO.inspect(params)
    uploaded_image = params["uploaded_image"]
    {:ok, binary_data} = File.read(uploaded_image.path)
    attributes = %{data: binary_data, uploaded_by: account.id}

    case Images.create_image(attributes) do
      {:ok, x} -> render(conn, :show, image: x)
      {:error, _e} -> conn |> put_status(:bad_request) |> json("failed to upload image")
    end
  end

  def index(conn, _params) do
    images = Images.list_images()
    render(conn, :index, images: images)
  end

  def create(conn, %{"image" => image_params}) do
    with {:ok, %Image{} = image} <- Images.create_image(image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/images/#{image}")
      |> render(:show, image: image)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Images.get_image!(id)
    render(conn, :show, image: image)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Images.get_image!(id)

    with {:ok, %Image{} = image} <- Images.update_image(image, image_params) do
      render(conn, :show, image: image)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Images.get_image!(id)

    with {:ok, %Image{}} <- Images.delete_image(image) do
      send_resp(conn, :no_content, "")
    end
  end
end
