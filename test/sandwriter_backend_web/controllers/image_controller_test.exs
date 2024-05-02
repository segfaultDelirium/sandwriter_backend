defmodule SandwriterBackendWeb.ImageControllerTest do
  use SandwriterBackendWeb.ConnCase

  import SandwriterBackend.ImagesFixtures

  alias SandwriterBackend.Images.Image

  @create_attrs %{
    data: "some data",
    title: "some title",
    deleted_at: ~N[2024-05-01 10:42:00]
  }
  @update_attrs %{
    data: "some updated data",
    title: "some updated title",
    deleted_at: ~N[2024-05-02 10:42:00]
  }
  @invalid_attrs %{data: nil, title: nil, deleted_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all images", %{conn: conn} do
      conn = get(conn, ~p"/api/images")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image" do
    test "renders image when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/images", image: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/images/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some data",
               "deleted_at" => "2024-05-01T10:42:00",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/images", image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image" do
    setup [:create_image]

    test "renders image when data is valid", %{conn: conn, image: %Image{id: id} = image} do
      conn = put(conn, ~p"/api/images/#{image}", image: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/images/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some updated data",
               "deleted_at" => "2024-05-02T10:42:00",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn = put(conn, ~p"/api/images/#{image}", image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete(conn, ~p"/api/images/#{image}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/images/#{image}")
      end
    end
  end

  defp create_image(_) do
    image = image_fixture()
    %{image: image}
  end
end
